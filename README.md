# OUI File List & Update Script

This repository contains a **cleaned and sorted OUI (Organizationally Unique Identifier) file** along with a script to automatically download, process, and update it.

---

## oui.txt

`oui.txt` is a text file containing a list of MAC address prefixes assigned to organizations worldwide. Each record includes:

- **MAC prefix** in `XX:XX:XX` format  
- **Company name**  
- **Country code** in parentheses
- for example: 04:2E:C1 Apple, Inc. (US)


This file is **sorted by company name** and includes both the official IEEE OUI list and additional OUIs from custom sources. The **update date** is included at the top of the file.

You can use `oui.txt` in your projects freely — it is ideal for **network analysis, MAC address lookup, and other networking applications**.

---

## Update_OUI_from_iEEE.sh

`Update_OUI_from_iEEE.sh` is a Bash script that automates the process of updating your OUI file. It performs the following steps:

1. **Downloads** the latest IEEE OUI database.  
2. **Processes** it to extract MAC prefixes, company names, and country codes.  
3. **Downloads extra OUIs** from a custom source and appends them to the list.  
4. **Sorts** the combined OUI list by MAC prefix.
5. **Creates a clean `oui.txt`** file with an update timestamp at the top.  


