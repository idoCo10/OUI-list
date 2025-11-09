#!/usr/bin/env bash

DESKTOP=~/Desktop
cd "$DESKTOP" || exit

menu() {
    echo -e "\nSelect an option:"
    echo "1: Download updated OUI from IEEE + Extra OUIs, create clean sorted oui.txt"
    echo "2: Sort existing oui.txt"
    echo "0: Exit"
    read -rp "Enter choice: " choice
}

process_oui() {
    echo -e "\nDownloading IEEE OUI database..."
    wget -O oui_raw.txt https://standards-oui.ieee.org/oui/oui.txt

    echo "Processing ieee oui_raw.txt to create oui.txt..."
    awk '
    /\(hex\)/ {
        mac_raw = substr($1,1,8)
        gsub(/-/,"",mac_raw)
        mac = toupper(substr(mac_raw,1,2) ":" substr(mac_raw,3,2) ":" substr(mac_raw,5,2))

        company = $0
        sub(/.*\(hex\)[ \t]*/,"",company)
        gsub(/[\r\n]+/, "", company)

        country = ""
        for (i = 0; i < 5; i++) {
            if (getline > 0) {
                line = $0
                gsub(/^[ \t\r\n]+|[ \t\r\n]+$/, "", line)
                if (length(line) == 2 && line ~ /^[A-Z]{2}$/) {
                    country = line
                    break
                }
            }
        }

        printf "%s %s (%s)\n", mac, company, country
    }
    ' oui_raw.txt > oui.txt

    echo -e "\nDownloading Extra_OUIs.txt..."
    wget -O Extra_OUIs.txt https://raw.githubusercontent.com/idoCo10/OUI-list-2025/main/Extra_OUIs.txt

    echo "Appending Extra_OUIs.txt to oui.txt..."
    cat Extra_OUIs.txt >> oui.txt

    # automatically sort with header
    sort_oui
}

sort_oui() {
    if [[ ! -f oui.txt ]]; then
        echo "oui.txt not found! Please run option 1 first."
        return
    fi

    echo -e "\nSorting oui.txt by company name..."
    DATE_NOW=$(date "+%d/%m/%Y %H:%M")

    # sort and prepend header
    {
        echo "=============================="
        echo "Update Date: $DATE_NOW"
        echo "=============================="
        sort -k2 -f oui.txt
    } > oui-sorted.txt

    mv oui-sorted.txt oui.txt
    echo "Done!"    
}


menu
case "$choice" in
    1) process_oui ;;
    2) sort_oui ;;
    0) echo "Exiting..."; exit ;;
    *) echo "Invalid choice." ;;
esac

