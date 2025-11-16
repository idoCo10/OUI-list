#!/usr/bin/env bash

DESKTOP=~/Desktop
cd "$DESKTOP" || exit



# --- Check if oui.txt exists and count old OUIs ---
if [[ -f oui.txt ]]; then
    old_oui_count=$(tail -n +5 oui.txt | grep -v '^[[:space:]]*$' | wc -l)
fi



echo -e "\nDownloading updated OUI from IEEE + Extra OUIs + sorting the file by company names.\n\n"


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

    echo -e "\n\nAppending Extra_OUIs.txt to oui.txt..."
    cat Extra_OUIs.txt >> oui.txt

    # automatically sort with header
    sort_oui
}

sort_oui() {
    if [[ ! -f oui.txt ]]; then
        echo "oui.txt not found! Please run option 1 first."
        return
    fi

    echo -e "Sorting oui.txt by MAC prefix..."
    DATE_NOW=$(date "+%d/%m/%Y %H:%M")

    # sort and prepend header
    {
        echo "=============================="
        echo "Update Date: $DATE_NOW"
        echo "Sorted by MAC prefix."
        echo "=============================="
        grep -v '^===' oui.txt | sort -u -k1,1 -k2 -f
    } > oui-sorted.txt

    mv oui-sorted.txt oui.txt
    echo "Removing raw files.."
    rm oui_raw.txt Extra_OUIs.txt
    
    oui_count=$(tail -n +5 oui.txt | grep -v '^[[:space:]]*$' | wc -l)
    echo -e "\n\nNumber of OUIs in the updated file: $oui_count"
    
    if [[ $old_oui_count -gt 0 ]]; then
        echo -e "\nNumber of OUIs before the update: $old_oui_count"
    fi    

    echo -e "\n\nDone!"    
}

process_oui


