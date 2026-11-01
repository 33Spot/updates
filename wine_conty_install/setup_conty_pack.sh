#!/usr/bin/env bash
# Usage: ./setup_conty_pack.sh [src_pack_dir] [dst_dir]
set -euo pipefail

# ---- Resolve directory where THIS script is located ----
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SRC_DIR="${1:-$SCRIPT_DIR/wine_conty_pack}"
DST_DIR="${2:-$SCRIPT_DIR/wine_conty_ln}"

# ==============================================================================
# CONTY VERSIONS LIST
# ------------------------------------------------------------------------------
# Add as many versions as you want below using pairs of lines:
#   Line 1: Folder name (e.g. conty_wine_1.29.4_conty4)
#   Line 2: Download URL
#           - Uncommented URL (https://...)       -> Selected (ON) by default
#           - Commented URL   (#   #https://...)  -> Unselected (OFF) by default
# ==============================================================================
CONTY_LIST='
conty_wine_1.29.4_conty4
https://github.com/Kron4ek/Conty/releases/download/1.29.4/conty_wine.sh

conty_wine_1.29.3_conty3
https://github.com/Kron4ek/Conty/releases/download/1.29.3/conty_wine.sh

conty_wine_1.29.2_conty2
https://github.com/Kron4ek/Conty/releases/download/1.29.2/conty_wine.sh

conty_wine_1.29.1_conty1
https://github.com/Kron4ek/Conty/releases/download/1.29.1/conty_wine.sh

conty_wine_1.29.0_conty0
#   #https://github.com/Kron4ek/Conty/releases/download/1.29/conty_wine.sh

conty_wine_1.28.4_conty284
#   #https://github.com/Kron4ek/Conty/releases/download/1.28.4/conty_wine.sh

conty_wine_1.28.3_conty283
#   #https://github.com/Kron4ek/Conty/releases/download/1.28.3/conty_wine.sh

conty_wine_1.28.2_conty282
https://github.com/Kron4ek/Conty/releases/download/1.28.2/conty_wine.sh

conty_wine_1.28.1_conty281
#   #https://github.com/Kron4ek/Conty/releases/download/1.28.1/conty_wine.sh

conty_wine_1.28.0_conty280
#   #https://github.com/Kron4ek/Conty/releases/download/1.28/conty_wine.sh

conty_wine_1.21.9_conty219
https://github.com/Kron4ek/Conty/releases/download/1.21.9/conty_wine.sh

conty_wine_1.21.10_conty2110
https://github.com/Kron4ek/Conty/releases/download/1.21.10/conty_wine.sh
'

# ==============================================================================
# 1. PARSE LIST & SHOW DIALOG MENU
# ==============================================================================
declare -A URL_MAP
MENU_ITEMS=()

pending_name=""
name_commented=0

while IFS= read -r raw_line || [ -n "$raw_line" ]; do
    line="${raw_line%$'\r'}"
    # Trim leading and trailing whitespace
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [ -z "$line" ] && continue

    if [[ "$line" == *http://* || "$line" == *https://* ]]; then
        # This is a URL line
        state="ON"
        if [[ "$line" == \#* ]] || [ "$name_commented" -eq 1 ]; then
            state="OFF"
        fi

        # Extract URL starting from http
        url="http${line#*http}"
        url="${url%%[[:space:]#]*}"

        if [ -n "$pending_name" ] && [ -n "$url" ]; then
            URL_MAP["$pending_name"]="$url"
            bin_file="$(basename "$url")"
            ver_tag="$(basename "$(dirname "$url")")"
            desc="$ver_tag ($bin_file)"
            if [ -f "$SRC_DIR/$pending_name/$bin_file" ]; then
                desc="$desc [already downloaded]"
            fi
            MENU_ITEMS+=("$pending_name" "$desc" "$state")
        fi
        pending_name=""
        name_commented=0
    else
        # This is a name line (or a regular comment)
        clean_name="$line"
        name_commented=0
        if [[ "$clean_name" == \#* ]]; then
            name_commented=1
            clean_name="${clean_name#"${clean_name%%[!#[:space:]]*}"}"
        fi
        # Ignore comment lines that contain spaces
        if [[ -n "$clean_name" && "$clean_name" != *[[:space:]]* ]]; then
            pending_name="$clean_name"
        fi
    fi
done <<< "$CONTY_LIST"

if [ "${#MENU_ITEMS[@]}" -eq 0 ]; then
    echo "Error: No Conty versions found in CONTY_LIST." >&2
    exit 1
fi

# Find dialog tool
DIALOG_BIN=""
if command -v dialog >/dev/null 2>&1; then
    DIALOG_BIN="dialog"
elif command -v whiptail >/dev/null 2>&1; then
    DIALOG_BIN="whiptail"
else
    echo "Error: Neither 'dialog' nor 'whiptail' is installed. Please install 'dialog'." >&2
    exit 1
fi

# Show checklist menu
set +e
SELECTED_VERSIONS=$(
    "$DIALOG_BIN" --clear \
        --backtitle "Conty Wine Pack Manager" \
        --title "Select Conty Versions" \
        --separate-output \
        --checklist "Choose Conty versions to download into $(basename "$SRC_DIR"):\n(Use SPACE to select/deselect, ENTER to confirm)" \
        20 85 12 \
        "${MENU_ITEMS[@]}" \
        2>&1 >/dev/tty
)
dialog_status=$?
set -e

clear
if [ "$dialog_status" -ne 0 ]; then
    echo "Menu cancelled by user. Exiting."
    exit 0
fi

# ==============================================================================
# 2. CREATE wine_conty_pack & DOWNLOAD SELECTED VERSIONS
# ==============================================================================
mkdir -p "$SRC_DIR"
SRC_ABS="$(cd "$SRC_DIR" && pwd)"

download_file() {
    local url="$1" dest="$2"
#    if command -v curl >/dev/null 2>&1; then
#        curl -fL --retry 3 -C - -o "$dest.part" "$url"
#    el
if command -v wget >/dev/null 2>&1; then
clear && wget -c -O "$dest.part" "$url"  2>&1 | \
 stdbuf -o0 awk '/[.] +[0-9][0-9]?[0-9]?%/ { print substr($0,63,3) }' | \
 dialog --gauge "Downloading: $url" 10 100
    else
        echo "Error: Neither 'curl' nor 'wget' is installed." >&2
        exit 1
    fi
    mv "$dest.part" "$dest"
}

if [ -n "$SELECTED_VERSIONS" ]; then
    while IFS= read -r name; do
        [ -z "$name" ] && continue
        url="${URL_MAP[$name]:-}"
        [ -z "$url" ] && continue

        target_dir="$SRC_ABS/$name"
        mkdir -p "$target_dir"

        filename="$(basename "$url")"
        # Ensure filename is either conty_wine.sh or conty.sh
        case "$filename" in
            conty_wine.sh|conty.sh) ;;
            *) filename="conty_wine.sh" ;;
        esac

        target_file="$target_dir/$filename"

        if [ -s "$target_file" ]; then
            echo "already exists: $target_file (skipping download)"
        else
            echo "downloading: $name"
            echo "  from: $url"
            echo "    to: $target_file"
            download_file "$url" "$target_file"
        fi

        chmod +x "$target_file"
    done <<< "$SELECTED_VERSIONS"
else
    echo "No versions selected for download."
fi

# Ensure all existing conty_wine.sh / conty.sh files in SRC_ABS are executable
for dir in "$SRC_ABS"/*/; do
    [ -d "$dir" ] || continue
    [ -f "$dir/conty_wine.sh" ] && chmod +x "$dir/conty_wine.sh"
    [ -f "$dir/conty.sh" ]      && chmod +x "$dir/conty.sh"
done

# ==============================================================================
# 3. CREATE wine_conty_ln & LAUNCHER SCRIPTS
# ==============================================================================
mkdir -p "$DST_DIR"
DST_ABS="$(cd "$DST_DIR" && pwd)"

# ---------- conty_config.txt (only created if missing) ----------
if [ ! -f "$DST_ABS/conty_config.txt" ]; then
    cat > "$DST_ABS/conty_config.txt" <<EOF
# Path to the folder that contains the conty_wine_* directories.
# You may use an absolute path, a ~path, or a path relative to this conty_config.txt
wine_conty_pack = $SRC_ABS
EOF
    echo "created: $DST_ABS/conty_config.txt"
fi

# ---------- launchers ----------
for dir in "$SRC_ABS"/*/; do
    [ -d "$dir" ] || continue
    name="$(basename "$dir")"

    bin_name=""
    if [ -f "$dir/conty_wine.sh" ]; then
        bin_name="conty_wine.sh"
    elif [ -f "$dir/conty.sh" ]; then
        bin_name="conty.sh"
    else
        echo "skip: $name (no conty_wine.sh or conty.sh)"
        continue
    fi

    mkdir -p "$DST_ABS/$name"
    out="$DST_ABS/$name/$bin_name"

    # --- header: the only per-version data (expanded now) ---
    cat > "$out" <<EOF
#!/usr/bin/env bash
# ---------------------------------------------------------------
# Auto-generated launcher for: $name
# Generated: $(date '+%Y-%m-%d %H:%M:%S')
# It locates the real $bin_name via conty_config.txt (searched upwards
# from this script's location, then from \$PWD), falling back to the
# defaults baked in below.
# ---------------------------------------------------------------
CONTY_NAME="$name"
CONTY_BIN="$bin_name"
DEFAULT_PACK_DIR="$SRC_ABS"
DEFAULT_CONFIG_DIR="$DST_ABS"
EOF

    # --- body: literal (quoted heredoc, nothing is expanded now) ---
    cat >> "$out" <<'EOF'

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
SELF_DIR="$(cd "$(dirname "$self")" && pwd)"

# ---- search conty_config.txt upwards from a directory ----
find_config() {
    local d="$1" i=0
    [ -d "$d" ] || return 1
    d="$(cd "$d" && pwd)"
    while [ "$i" -lt 32 ]; do
        [ -f "$d/conty_config.txt" ] && { printf '%s\n' "$d/conty_config.txt"; return 0; }
        [ "$d" = "/" ] && break
        d="$(dirname "$d")"
        i=$((i+1))
    done
    return 1
}

# ---- read the pack path out of a conty_config.txt ----
# accepted lines:  /some/path      |  wine_conty_pack = /some/path
# '#' and ';' start a comment, quotes and ~ are handled
read_config() {
    local f="$1" line val
    while IFS= read -r line || [ -n "$line" ]; do
        line="${line%$'\r'}"
        line="${line%%#*}"; line="${line%%;*}"
        line="${line#"${line%%[![:space:]]*}"}"
        line="${line%"${line##*[![:space:]]}"}"
        [ -z "$line" ] && continue
        case "$line" in
            *=*) val="${line#*=}" ;;
            *)   val="$line" ;;
        esac
        val="${val#"${val%%[![:space:]]*}"}"
        val="${val%"${val##*[![:space:]]}"}"
        val="${val%\"}"; val="${val#\"}"
        val="${val%\'}"; val="${val#\'}"
        val="${val/#\~/$HOME}"
        [ -n "$val" ] && { printf '%s\n' "$val"; return 0; }
    done < "$f"
    return 1
}

PACK_DIR=""
CFG=""

# 1) environment overrides
if [ -n "${WINE_CONTY_PACK:-}" ]; then
    PACK_DIR="$WINE_CONTY_PACK"
elif [ -n "${CONTY_CONFIG:-}" ] && [ -f "$CONTY_CONFIG" ]; then
    CFG="$CONTY_CONFIG"
    PACK_DIR="$(read_config "$CFG")" || PACK_DIR=""
fi

# 2) conty_config.txt: upwards from script dir, upwards from $PWD, then default dir
if [ -z "$PACK_DIR" ]; then
    for base in "$SELF_DIR" "$PWD" "$DEFAULT_CONFIG_DIR"; do
        CFG="$(find_config "$base")" || continue
        PACK_DIR="$(read_config "$CFG")" || { PACK_DIR=""; continue; }
        [ -n "$PACK_DIR" ] && break
    done
fi

# 3) relative path in conty_config.txt -> relative to the config file itself
case "$PACK_DIR" in
    ""|/*) : ;;
    *) [ -n "$CFG" ] && PACK_DIR="$(cd "$(dirname "$CFG")" && cd "$PACK_DIR" 2>/dev/null && pwd)" ;;
esac

# 4) last resort
[ -z "$PACK_DIR" ] && PACK_DIR="$DEFAULT_PACK_DIR"

# ---- find the real conty_wine.sh / conty.sh ----
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
    [ -f "$cand" ] && { TARGET="$cand"; break; }
done

if [ -z "$TARGET" ]; then
    echo "conty launcher ($CONTY_NAME): cannot find the real $CONTY_BIN" >&2
    echo "  conty_config.txt used : ${CFG:-<none found>}" >&2
    echo "  pack dir tried  : $PACK_DIR" >&2
    echo "  expected file   : $PACK_DIR/$CONTY_NAME/$CONTY_BIN" >&2
    echo "Fix conty_config.txt (one level above this script) or set WINE_CONTY_PACK=/path" >&2
    exit 127
fi

[ "${CONTY_LAUNCHER_VERBOSE:-0}" = "1" ] && echo "-> $TARGET" >&2

if [ -x "$TARGET" ]; then
    exec "$TARGET" "$@"
else
    exec bash "$TARGET" "$@"
fi
EOF

    chmod +x "$out"
    echo "created: $out"
done
