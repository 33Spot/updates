#!/bin/bash
# Sklep Portable Linux Apps (Graficzny interfejs dla AM)
# Funkcje: dokładne listy, graficzne hasło sudo, instalacja/usuwanie, zapamiętuje ostatnią bazę danych


KATALOG_KONFIG="$HOME/.config"
PLIK_KONFIG="$KATALOG_KONFIG/am-store.conf"
mkdir -p "$KATALOG_KONFIG"

# ---------------- Pomocnicze funkcje GUI ----------------

wybierz_baze() {
    zenity --list --title="Wybierz bazę AM" --radiolist \
        --column="Wybierz" --column="Baza danych" \
        TRUE "am" FALSE "appimages" FALSE "portable" FALSE "busybox" \
        FALSE "python" FALSE "appbundle" FALSE "soarpkg" FALSE "all" \
        --height=400 --width=300
}

# Pobierz listę dostępnych programów po linijce "LIST OF THE #### PROGRAMS AVAILABLE"
# Zachowaj kolejność, usuń diamenty, puste linie i wpisy "FALSE"
# Przenieś "0ad" na początek jeśli istnieje
pobierz_liste_programow() {
    local baza="$1"
    local surowe
    if [ "$baza" = "am" ]; then
        surowe=$(am -l)
    else
        surowe=$(am -l --"$baza")
    fi

    local lista
    lista=$(printf "%s\n" "$surowe" | awk '
        /LIST OF THE [0-9]+ PROGRAMS AVAILABLE/ {capture=1; next}
        /^To list all installable programs/ {capture=0}
        capture && NF>0 && !/FALSE/ && !/^ *$/ {print}
    ' | sed 's/^[[:space:]]*◆[[:space:]]*//' )

    if [ -z "$lista" ]; then
        printf ""
        return
    fi

    if printf "%s\n" "$lista" | grep -xq "0ad"; then
        {
            printf "0ad\n"
            printf "%s\n" "$lista" | awk '$0 != "0ad" {print}'
        } | awk '!seen[$0]++ {print}'
    else
        printf "%s\n" "$lista" | awk '!seen[$0]++ {print}'
    fi
}

# Pobierz listę zainstalowanych programów po "YOU HAVE INSTALLED" i przed "To list all installable programs"
pobierz_zainstalowane() {
    am -l | awk '
        /YOU HAVE INSTALLED/ {capture=1; next}
        /To list all installable programs/ {capture=0}
        capture && NF>0 && !/FALSE/ && !/^ *$/ {print}
    ' | sed 's/^[[:space:]]*◆[[:space:]]*//' | sort -u
}

# ---------------- Czynności wymagające uprawnień ----------------

zainstaluj_program() {
    local program="$1"
    pkexec bash -c "am -i \"$program\" 2>&1" | \
    awk '
        BEGIN {i=0}
        {
            i++
            if (i % 5 == 0) {
                p = i % 100
                if (p > 100) p = 100
                print p
                fflush()
            }
            print "# " $0
            fflush()
        }
        END {print 100}
    ' | zenity --progress \
        --title="Instalowanie $program" --text="Instalowanie..." \
        --percentage=0 --auto-close --width=600 --height=150
}

usun_program() {
    local program="$1"
    pkexec bash -c "am -R \"$program\" 2>&1" | \
    awk '
        BEGIN {i=0}
        {
            i++
            if (i % 4 == 0) {
                p = i % 100
                if (p > 100) p = 100
                print p
                fflush()
            }
            print "# " $0
            fflush()
        }
        END {print 100}
    ' | zenity --progress \
        --title="Usuwanie $program" --text="Usuwanie..." \
        --percentage=0 --auto-close --width=600 --height=150
}

# ---------------- Lista zainstalowanych programów ----------------
pokaz_zainstalowane() {
    local lista
    lista=$(pobierz_zainstalowane)
    if [ -z "$lista" ]; then
        zenity --info --title="AM Sklep" --text="Brak zainstalowanych programów." --timeout=3
    else
        echo "$lista" | zenity --list \
            --title="Lista zainstalowanych programów" \
            --column="Zainstalowane programy" --height=600 --width=600
    fi
}

# ---------------- Główna pętla ----------------

if [ -f "$PLIK_KONFIG" ]; then
    BAZA=$(<"$PLIK_KONFIG")
fi

while true; do
    AKCJA=$(zenity --list --title="AM Sklep" --text="Wybierz czynność:" \
        --column="Działanie" \
        "Zainstaluj program" \
        "Usuń program" \
        "Pokaż listę zainstalowanych programów" \
        "Zmień bazę danych" \
        "Zakończ" \
        --height=320 --width=360) || exit 0

    case "$AKCJA" in
        "Zainstaluj program")
            [ -z "$BAZA" ] && BAZA=$(wybierz_baze)
            [ -z "$BAZA" ] && continue
            echo "$BAZA" > "$PLIK_KONFIG"

            PROGRAM=$(pobierz_liste_programow "$BAZA" | zenity --list \
                --title="Instalacja programu z bazy '$BAZA'" \
                --column="Dostępne programy" --height=600 --width=600)

            [ -n "$PROGRAM" ] && zainstaluj_program "$PROGRAM"
            ;;
        "Usuń program")
            ZAINSTALOWANE=$(pobierz_zainstalowane)
            PROGRAM=$(echo "$ZAINSTALOWANE" | zenity --list \
                --title="Usuń zainstalowany program" \
                --column="Zainstalowane programy" --height=600 --width=600)
            [ -n "$PROGRAM" ] && usun_program "$PROGRAM"
            ;;
        "Pokaż listę zainstalowanych programów")
            pokaz_zainstalowane
            ;;
        "Zmień bazę danych")
            BAZA=$(wybierz_baze)
            [ -n "$BAZA" ] && echo "$BAZA" > "$PLIK_KONFIG"
            ;;
        "Zakończ")
            break
            ;;
    esac
done

