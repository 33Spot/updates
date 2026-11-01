#!/usr/bin/env bash
# Conty Wine Pack Studio
# Usage: ./setup_conty_wine.sh [src_pack_dir] [dst_dir]
set -euo pipefail

BACKTITLE="CONTY WINE PACK STUDIO  |  Portable Windows apps on Linux"
DIALOG_BIN=""

show_msg() {
    local title="$1"
    local text="$2"
    local height="${3:-16}"
    local width="${4:-78}"

    "$DIALOG_BIN" --clear \
        --backtitle "$BACKTITLE" \
        --title "$title" \
        --msgbox "$text" "$height" "$width" || true
}

on_error() {
    local status=$?
    local line="${BASH_LINENO[0]:-unknown}"
    trap - ERR

    if [[ -n "$DIALOG_BIN" ]] && command -v "$DIALOG_BIN" >/dev/null 2>&1 && [[ -t 2 ]]; then
        "$DIALOG_BIN" --clear \
            --backtitle "$BACKTITLE" \
            --title "SETUP ERROR" \
            --msgbox "An unexpected error occurred.

Exit status: $status
Script line: $line" 12 72 || true
    else
        printf 'Setup failed (exit status %s, line %s).\n' "$status" "$line" >&2
    fi

    exit "$status"
}

if ! command -v dialog >/dev/null 2>&1; then
    printf "This script requires 'dialog'. Install it, then run this script again.\n" >&2
    exit 127
fi

DIALOG_BIN="$(command -v dialog)"

if [[ ! -t 2 ]]; then
    printf "Run this script from an interactive terminal so dialog can display its screens.\n" >&2
    exit 1
fi

trap on_error ERR

if (( $# > 2 )); then
    show_msg "USAGE" "Usage:

  $0 [src_pack_dir] [dst_dir]

By default, both folders are created beside this script." 12 72
    exit 2
fi

SCRIPT_PATH="${BASH_SOURCE[0]}"
if [[ "$SCRIPT_PATH" != */* ]]; then
    SCRIPT_PATH="./$SCRIPT_PATH"
fi
SCRIPT_DIR="$(cd -- "$(dirname -- "$SCRIPT_PATH")" && pwd -P)"

absolute_path() {
    if [[ "$1" == /* ]]; then
        printf '%s\n' "$1"
    else
        printf '%s/%s\n' "$PWD" "$1"
    fi
}

SRC_DIR="${1:-$SCRIPT_DIR/wine_conty_pack}"
DST_DIR="${2:-$SCRIPT_DIR/wine_conty_ln}"
SRC_DIR="$(absolute_path "$SRC_DIR")"
DST_DIR="$(absolute_path "$DST_DIR")"

# ON = checked by default. OFF = visible, but unchecked by default.
# Format: state|folder name|download URL
VERSION_DATA=$(cat <<'EOF'
ON|conty_wine_1.29.4_conty4|https://github.com/Kron4ek/Conty/releases/download/1.29.4/conty_wine.sh
ON|conty_wine_1.29.3_conty3|https://github.com/Kron4ek/Conty/releases/download/1.29.3/conty_wine.sh
ON|conty_wine_1.29.2_conty2|https://github.com/Kron4ek/Conty/releases/download/1.29.2/conty_wine.sh
ON|conty_wine_1.29.1_conty1|https://github.com/Kron4ek/Conty/releases/download/1.29.1/conty_wine.sh
OFF|conty_wine_1.29.0_conty0|https://github.com/Kron4ek/Conty/releases/download/1.29/conty_wine.sh
OFF|conty_wine_1.28.4_conty284|https://github.com/Kron4ek/Conty/releases/download/1.28.4/conty_wine.sh
OFF|conty_wine_1.28.3_conty283|https://github.com/Kron4ek/Conty/releases/download/1.28.3/conty_wine.sh
ON|conty_wine_1.28.2_conty282|https://github.com/Kron4ek/Conty/releases/download/1.28.2/conty_wine.sh
OFF|conty_wine_1.28.1_conty281|https://github.com/Kron4ek/Conty/releases/download/1.28.1/conty_wine.sh
OFF|conty_wine_1.28.0_conty280|https://github.com/Kron4ek/Conty/releases/download/1.28/conty_wine.sh
ON|conty_wine_1.21.9_conty219|https://github.com/Kron4ek/Conty/releases/download/1.21.9/conty_wine.sh
ON|conty_wine_1.21.10_conty2110|https://github.com/Kron4ek/Conty/releases/download/1.21.10/conty_wine.sh
EOF
)

declare -a VERSION_NAMES=()
declare -A VERSION_URL=()
declare -A VERSION_DEFAULT=()
declare -A VERSION_FILE=()

while IFS='|' read -r state name url; do
    if [[ -z "${name:-}" ]]; then
        continue
    fi

    VERSION_NAMES+=("$name")
    VERSION_URL["$name"]="$url"
    VERSION_DEFAULT["$name"]="$state"
    VERSION_FILE["$name"]="${url##*/}"
done <<< "$VERSION_DATA"

WELCOME_ART=$(cat <<'ART'
  +--------------------------------------------------+
  |                                                  |
  |          C O N T Y   +   W I N E                |
  |                                                  |
  |    [ Conty container ]  +  [ Wine runtime ]      |
  |                                                  |
  |           Windows apps on Linux                 |
  +--------------------------------------------------+
ART
)

WELCOME_TEXT="$WELCOME_ART

A guided builder for your Conty Wine pack.

  1. Choose the releases you want.
  2. Watch a live progress bar for each download.
  3. Set executable permissions and create launchers.

PACK DIRECTORY
  $SRC_DIR

LAUNCHER DIRECTORY
  $DST_DIR

Press Enter to begin."

"$DIALOG_BIN" --clear \
    --backtitle "$BACKTITLE" \
    --title "WELCOME | CONTY WINE PACK BUILDER" \
    --msgbox "$WELCOME_TEXT" 21 78 || true

declare -a MENU_ITEMS=()

for name in "${VERSION_NAMES[@]}"; do
    state="${VERSION_DEFAULT[$name]}"
    filename="${VERSION_FILE[$name]}"

    if [[ "$state" == "ON" ]]; then
        description="DEFAULT - selected"
    else
        description="OPTIONAL - not selected"
    fi

    if [[ -s "$SRC_DIR/$name/$filename" ]]; then
        description="$description | present"
    fi

    MENU_ITEMS+=("$name" "$description" "$state")
done

MENU_PROMPT=$'Use UP/DOWN to browse, SPACE to toggle, ENTER to continue.\nON = selected by default; OFF = optional.\n'
MENU_PROMPT+="Pack directory: $SRC_DIR"

if SELECTED_VERSIONS=$(
    "$DIALOG_BIN" --clear \
        --backtitle "$BACKTITLE" \
        --title "STEP 1 | CHOOSE CONTY WINE VERSIONS" \
        --stdout \
        --separate-output \
        --checklist "$MENU_PROMPT" \
        22 78 12 \
        "${MENU_ITEMS[@]}"
); then
    :
else
    show_msg "CANCELLED" "No changes were made." 10 60
    exit 0
fi

selected_count=0
selected_text=""

while IFS= read -r selected_name; do
    if [[ -z "$selected_name" ]]; then
        continue
    fi

    selected_count=$((selected_count + 1))
    selected_text+=$'  - '"$selected_name"$'\n'
done <<< "$SELECTED_VERSIONS"

if [[ "$selected_count" -eq 0 ]]; then
    confirmation="No versions are selected, so no files will be downloaded.

Existing scripts in the pack directory will still be made executable and used to build launchers.

Continue?"
else
    confirmation="Selected releases ($selected_count):

$selected_text
Existing scripts will be kept. Missing scripts will be downloaded.

Pack directory:
  $SRC_DIR

Launcher directory:
  $DST_DIR

Continue?"
fi

if ! "$DIALOG_BIN" --clear \
    --backtitle "$BACKTITLE" \
    --title "STEP 2 | CONFIRM SETUP" \
    --yesno "$confirmation" 22 78; then
    show_msg "CANCELLED" "Setup was cancelled. No changes were made." 10 64
    exit 0
fi

if ! WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/conty-wine-pack.XXXXXX" 2>/dev/null)"; then
    show_msg "SETUP ERROR" "Could not create a temporary working directory." 10 68
    exit 1
fi

cleanup() {
    rm -rf -- "${WORK_DIR:-}" 2>/dev/null || true
}
trap cleanup EXIT

if ! mkdir -p -- "$SRC_DIR" 2>"$WORK_DIR/setup-error.log"; then
    details="$(cat "$WORK_DIR/setup-error.log" 2>/dev/null || true)"
    show_msg "SETUP ERROR" "Could not create the pack directory:

$SRC_DIR

$details" 14 78
    exit 1
fi

if ! SRC_ABS="$(cd -- "$SRC_DIR" 2>"$WORK_DIR/path-error.log" && pwd -P)"; then
    show_msg "SETUP ERROR" "Could not access the pack directory:

$SRC_DIR" 12 72
    exit 1
fi

needs_download=0
while IFS= read -r selected_name; do
    if [[ -z "$selected_name" ]]; then
        continue
    fi

    filename="${VERSION_FILE[$selected_name]}"
    if [[ ! -s "$SRC_ABS/$selected_name/$filename" ]]; then
        needs_download=1
        break
    fi
done <<< "$SELECTED_VERSIONS"

downloader_available=1
if [[ "$needs_download" -eq 1 ]]; then
    if ! command -v curl >/dev/null 2>&1 && ! command -v wget >/dev/null 2>&1; then
        downloader_available=0
        show_msg "DOWNLOADER NOT FOUND" "Neither curl nor wget is installed.

Missing releases will be skipped. Existing pack files will still be used to build launchers.

Install curl or wget if you want to download the missing releases." 16 76
    fi
fi

progress_to_dialog() {
    local line=""
    local pct
    local numeric_pct

    while IFS= read -r -d $'\r' line || [[ -n "$line" ]]; do
        if [[ "$line" =~ ([0-9]{1,3})(\.[0-9]+)?% ]]; then
            pct="${BASH_REMATCH[1]}"
            numeric_pct=$((10#$pct))

            if (( numeric_pct > 100 )); then
                numeric_pct=100
            fi

            printf '%s\n' "$numeric_pct"
        fi
    done
}

download_to_dialog() {
    local name="$1"
    local url="$2"
    local part_file="$3"
    local index="$4"
    local total="$5"
    local log_file="$6"
    local prompt
    local downloader_status
    local -a pipeline_status=()

    printf -v prompt \
        'Release %s of %s\n\n%s\n\nSource:\n%s\n\nDownload progress:' \
        "$index" "$total" "$name" "$url"

    set +e
    if command -v curl >/dev/null 2>&1; then
        curl --fail --location --retry 3 --retry-delay 1 \
            --connect-timeout 30 --progress-bar \
            --output "$part_file" "$url" 2>&1
    else
        wget --tries=3 --timeout=30 \
            --progress=bar:force:noscroll \
            -O "$part_file" "$url" 2>&1
    fi |
        tee "$log_file" 2>/dev/null |
        progress_to_dialog |
        "$DIALOG_BIN" --clear \
            --backtitle "$BACKTITLE" \
            --title "STEP 3 | DOWNLOADING $index OF $total" \
            --gauge "$prompt" 10 78 0

    pipeline_status=( "${PIPESTATUS[@]}" )
    set -e

    downloader_status="${pipeline_status[0]:-1}"

    if [[ "$downloader_status" -eq 0 && -s "$part_file" ]]; then
        return 0
    fi

    return 1
}

show_download_failure() {
    local name="$1"
    local url="$2"
    local log_file="$3"
    local details="No additional transfer details were captured."

    if [[ -f "$log_file" ]]; then
        details="$(
            LC_ALL=C tr '\r' '\n' < "$log_file" |
                sed '/^[[:space:]]*$/d' |
                tail -n 8 |
                tr -cd '\11\12\15\40-\176' 2>/dev/null || true
        )"

        if [[ -z "$details" ]]; then
            details="No additional transfer details were captured."
        fi
    fi

    show_msg "DOWNLOAD FAILED" "Could not download:

$name

URL:
$url

Last output:
$details

The remaining selected versions will still be processed." 22 78
}

selected_index=0
downloaded_count=0
already_present_count=0
download_issue_count=0
download_issue_list=""

while IFS= read -r name; do
    if [[ -z "$name" ]]; then
        continue
    fi

    selected_index=$((selected_index + 1))
    url="${VERSION_URL[$name]}"
    filename="${VERSION_FILE[$name]}"
    target_dir="$SRC_ABS/$name"
    target_file="$target_dir/$filename"

    if ! mkdir -p -- "$target_dir" 2>"$WORK_DIR/mkdir-version-error.log"; then
        download_issue_count=$((download_issue_count + 1))
        download_issue_list+=$'\n  - '"$name (could not create its folder)"
        show_msg "FOLDER ERROR" "Could not create:

$target_dir" 12 76
        continue
    fi

    if [[ -s "$target_file" ]]; then
        if chmod +x -- "$target_file" 2>"$WORK_DIR/chmod-error.log"; then
            already_present_count=$((already_present_count + 1))
        else
            download_issue_count=$((download_issue_count + 1))
            download_issue_list+=$'\n  - '"$name (could not set executable permission)"
            show_msg "PERMISSION ERROR" "Could not make this file executable:

$target_file" 12 76
        fi
        continue
    fi

    if [[ "$downloader_available" -eq 0 ]]; then
        download_issue_count=$((download_issue_count + 1))
        download_issue_list+=$'\n  - '"$name (no curl or wget available)"
        continue
    fi

    part_file="$target_file.part.$$"
    log_file="$WORK_DIR/$name-download.log"
    rm -f -- "$part_file" 2>/dev/null || true

    if download_to_dialog \
        "$name" "$url" "$part_file" "$selected_index" "$selected_count" "$log_file"; then

        if ! mv -- "$part_file" "$target_file" 2>"$WORK_DIR/move-error.log"; then
            rm -f -- "$part_file" 2>/dev/null || true
            download_issue_count=$((download_issue_count + 1))
            download_issue_list+=$'\n  - '"$name (downloaded, but could not save the file)"
            show_msg "SAVE ERROR" "The download finished, but the file could not be saved:

$target_file" 12 76
            continue
        fi

        if ! chmod +x -- "$target_file" 2>"$WORK_DIR/chmod-error.log"; then
            download_issue_count=$((download_issue_count + 1))
            download_issue_list+=$'\n  - '"$name (could not set executable permission)"
            show_msg "PERMISSION ERROR" "The downloaded file could not be made executable:

$target_file" 12 76
            continue
        fi

        downloaded_count=$((downloaded_count + 1))
    else
        rm -f -- "$part_file" 2>/dev/null || true
        download_issue_count=$((download_issue_count + 1))
        download_issue_list+=$'\n  - '"$name (download failed)"
        show_download_failure "$name" "$url" "$log_file"
    fi
done <<< "$SELECTED_VERSIONS"

stage_text="The download stage is finished.

New scripts downloaded: $downloaded_count
Already present: $already_present_count
Issues: $download_issue_count

Next, scripts in the pack will be made executable and launcher wrappers will be generated.

Press Enter to continue."
show_msg "STEP 4 | BUILD LAUNCHERS" "$stage_text" 18 78

if ! mkdir -p -- "$DST_DIR" 2>"$WORK_DIR/dst-error.log"; then
    details="$(cat "$WORK_DIR/dst-error.log" 2>/dev/null || true)"
    show_msg "SETUP ERROR" "Could not create the launcher directory:

$DST_DIR

$details" 14 78
    exit 1
fi

if ! DST_ABS="$(cd -- "$DST_DIR" 2>"$WORK_DIR/dst-path-error.log" && pwd -P)"; then
    show_msg "SETUP ERROR" "Could not access the launcher directory:

$DST_DIR" 12 72
    exit 1
fi

case "$DST_ABS/" in
    "$SRC_ABS/"*)
        show_msg "INVALID FOLDER LAYOUT" "The launcher directory must not be inside the pack directory.

Pack:
  $SRC_ABS

Launchers:
  $DST_ABS

Choose separate folders and run the script again." 16 78
        exit 1
        ;;
esac

config_file="$DST_ABS/conty_config.txt"
if [[ -f "$config_file" ]]; then
    config_state="kept existing"
else
    if ! {
        printf '%s\n' \
            '# Path to the folder containing the Conty version directories.' \
            '# This may be an absolute path or a path relative to this config file.' \
            "wine_conty_pack = $SRC_ABS"
    } > "$config_file" 2>"$WORK_DIR/config-error.log"; then
        show_msg "CONFIG ERROR" "Could not create:

$config_file" 12 72
        exit 1
    fi
    config_state="created"
fi

launcher_count=0
skipped_directory_count=0
generation_error_count=0
generation_warning_list=""

for dir in "$SRC_ABS"/*/; do
    if [[ ! -d "$dir" ]]; then
        continue
    fi

    name="$(basename -- "$dir")"

    for source_file in "$dir/conty_wine.sh" "$dir/conty.sh"; do
        if [[ -f "$source_file" ]]; then
            if ! chmod +x -- "$source_file" 2>"$WORK_DIR/pack-chmod-error.log"; then
                generation_error_count=$((generation_error_count + 1))
                generation_warning_list+=$'\n  - Could not chmod: '"$source_file"
            fi
        fi
    done

    if [[ -f "$dir/conty_wine.sh" ]]; then
        bin_name="conty_wine.sh"
    elif [[ -f "$dir/conty.sh" ]]; then
        bin_name="conty.sh"
    else
        skipped_directory_count=$((skipped_directory_count + 1))
        continue
    fi

    launcher_dir="$DST_ABS/$name"
    if ! mkdir -p -- "$launcher_dir" 2>"$WORK_DIR/launcher-mkdir-error.log"; then
        generation_error_count=$((generation_error_count + 1))
        generation_warning_list+=$'\n  - Could not create launcher folder: '"$launcher_dir"
        continue
    fi

    launcher_file="$launcher_dir/$bin_name"

    printf -v quoted_name '%q' "$name"
    printf -v quoted_bin '%q' "$bin_name"
    printf -v quoted_pack '%q' "$SRC_ABS"
    printf -v quoted_config '%q' "$DST_ABS"
    generated_at="$(date '+%Y-%m-%d %H:%M:%S')"

    if ! {
        cat <<HEADER
#!/usr/bin/env bash
# ---------------------------------------------------------------
# Auto-generated Conty launcher for: $name
# Generated: $generated_at
# It locates the real script via conty_config.txt, searched upward
# from this launcher's directory and then from \$PWD.
# ---------------------------------------------------------------
CONTY_NAME=$quoted_name
CONTY_BIN=$quoted_bin
DEFAULT_PACK_DIR=$quoted_pack
DEFAULT_CONFIG_DIR=$quoted_config
HEADER
        cat <<'LAUNCHER_BODY'

set -uo pipefail

# ---- real directory of THIS script (resolves symlinks) ----
self="${BASH_SOURCE[0]}"
while [ -L "$self" ]; do
    link="$(readlink "$self")"
    case "$link" in
        /*) self="$link" ;;
        *)  self="$(dirname "$self")/$link" ;;
    esac
done
SELF_DIR="$(cd "$(dirname "$self")" && pwd -P)"

# ---- search conty_config.txt upwards from a directory ----
find_config() {
    local d="$1" i=0
    [ -d "$d" ] || return 1
    d="$(cd "$d" && pwd -P)" || return 1

    while [ "$i" -lt 32 ]; do
        [ -f "$d/conty_config.txt" ] && {
            printf '%s\n' "$d/conty_config.txt"
            return 0
        }

        [ "$d" = "/" ] && break
        d="$(dirname "$d")"
        i=$((i + 1))
    done

    return 1
}

# ---- read the pack path out of a conty_config.txt ----
read_config() {
    local f="$1" line val

    while IFS= read -r line || [ -n "$line" ]; do
        line="${line%$'\r'}"
        line="${line%%#*}"
        line="${line%%;*}"
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"

        [ -z "$line" ] && continue

        case "$line" in
            *=*) val="${line#*=}" ;;
            *)   val="$line" ;;
        esac

        val="${val#"${val%%[![:space:]]*}"}"
        val="${val%"${val##*[![:space:]]}"}"
        val="${val%\"}"
        val="${val#\"}"
        val="${val%\'}"
        val="${val#\'}"
        val="${val/#\~/$HOME}"

        [ -n "$val" ] && {
            printf '%s\n' "$val"
            return 0
        }
    done < "$f"

    return 1
}

PACK_DIR=""
CFG=""

# 1) Environment overrides
if [ -n "${WINE_CONTY_PACK:-}" ]; then
    PACK_DIR="$WINE_CONTY_PACK"
elif [ -n "${CONTY_CONFIG:-}" ] && [ -f "$CONTY_CONFIG" ]; then
    CFG="$CONTY_CONFIG"
    PACK_DIR="$(read_config "$CFG")" || PACK_DIR=""
fi

# 2) Search for a config upwards from the launcher, PWD, and default config dir
if [ -z "$PACK_DIR" ]; then
    for base in "$SELF_DIR" "$PWD" "$DEFAULT_CONFIG_DIR"; do
        CFG="$(find_config "$base")" || continue
        PACK_DIR="$(read_config "$CFG")" || PACK_DIR=""
        [ -n "$PACK_DIR" ] && break
    done
fi

# 3) Resolve relative pack paths
case "$PACK_DIR" in
    ""|/*)
        ;;
    *)
        resolved=""
        if [ -n "$CFG" ]; then
            resolved="$(
                cd "$(dirname "$CFG")" 2>/dev/null &&
                cd "$PACK_DIR" 2>/dev/null &&
                pwd -P
            )" || resolved=""
        else
            resolved="$(cd "$PACK_DIR" 2>/dev/null && pwd -P)" || resolved=""
        fi
        PACK_DIR="$resolved"
        ;;
esac

# 4) Last resort
[ -z "$PACK_DIR" ] && PACK_DIR="$DEFAULT_PACK_DIR"

# ---- find the real Conty script ----
TARGET=""

for cand in \
    "$PACK_DIR/$CONTY_NAME/$CONTY_BIN" \
    "$PACK_DIR/$CONTY_NAME/conty_wine.sh" \
    "$PACK_DIR/$CONTY_NAME/conty.sh" \
    "$PACK_DIR/$CONTY_BIN" \
    "$PACK_DIR/conty_wine.sh" \
    "$PACK_DIR/conty.sh" \
    "$DEFAULT_PACK_DIR/$CONTY_NAME/$CONTY_BIN" \
    "$DEFAULT_PACK_DIR/$CONTY_NAME/conty_wine.sh" \
    "$DEFAULT_PACK_DIR/$CONTY_NAME/conty.sh"
do
    if [ -f "$cand" ]; then
        TARGET="$cand"
        break
    fi
done

if [ -z "$TARGET" ]; then
    echo "Conty launcher ($CONTY_NAME): cannot find the real $CONTY_BIN" >&2
    echo "  Config used : ${CFG:-<none found>}" >&2
    echo "  Pack tried  : $PACK_DIR" >&2
    echo "  Expected    : $PACK_DIR/$CONTY_NAME/$CONTY_BIN" >&2
    echo "Fix conty_config.txt or set WINE_CONTY_PACK=/path" >&2
    exit 127
fi

[ "${CONTY_LAUNCHER_VERBOSE:-0}" = "1" ] && echo "-> $TARGET" >&2

if [ -x "$TARGET" ]; then
    exec "$TARGET" "$@"
else
    exec bash "$TARGET" "$@"
fi
LAUNCHER_BODY
    } > "$launcher_file" 2>"$WORK_DIR/launcher-write-error.log"; then
        generation_error_count=$((generation_error_count + 1))
        generation_warning_list+=$'\n  - Could not write launcher: '"$launcher_file"
        continue
    fi

    if ! chmod +x -- "$launcher_file" 2>"$WORK_DIR/launcher-chmod-error.log"; then
        generation_error_count=$((generation_error_count + 1))
        generation_warning_list+=$'\n  - Could not chmod launcher: '"$launcher_file"
        continue
    fi

    launcher_count=$((launcher_count + 1))
done

final_text="Setup finished.

Pack directory:
  $SRC_ABS

Launcher directory:
  $DST_ABS

Downloads:
  New: $downloaded_count
  Already present: $already_present_count
  Issues: $download_issue_count

Launchers created: $launcher_count
Config file: $config_state

Launchers are organized into one subfolder per Conty version."

if [[ -n "$download_issue_list" ]]; then
    final_text+=$'\n\nDownload issues:'"$download_issue_list"
fi

if [[ -n "$generation_warning_list" ]]; then
    final_text+=$'\n\nLauncher/permission issues:'"$generation_warning_list"
fi

if [[ "$launcher_count" -eq 0 ]]; then
    final_text+=$'\n\nNo launchers were created. Check that the pack contains conty_wine.sh or conty.sh files.'
fi

if [[ "$download_issue_count" -gt 0 || "$generation_error_count" -gt 0 ]]; then
    final_title="SETUP FINISHED WITH WARNINGS"
else
    final_title="SETUP COMPLETE"
fi

show_msg "$final_title" "$final_text" 24 78

if [[ "$download_issue_count" -gt 0 || "$generation_error_count" -gt 0 ]]; then
    exit 1
fi

exit 0
