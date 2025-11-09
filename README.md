# OUI File List & Update Script

This repository contains a **cleaned and sorted OUI (Organizationally Unique Identifier) file** along with a script to automatically download, process, and update it.

---

## oui.txt

`oui.txt` is a text file containing a list of MAC address prefixes assigned to organizations worldwide. Each record includes:

- **MAC prefix** in `XX:XX:XX` format  
- **Company name**  
- **Country code** in parentheses  

Example entries:

==============================
Update Date: 09/11/2025 18:17
==============================
70:02:58 01DB-METRAVIB (FR)
C4:93:13 100fio networks technology llc (US)
08:00:24 10NET COMMUNICATIONS/DCA (US)
00:0B:10 11wave Technonlogy Co.,Ltd (TW)
3C:40:15 12mm Health Technology (Hainan) Co., Ltd. (CN)
A8:5E:E4 12Sided Technology, LLC (US)
00:50:29 1394 PRINTER WORKING GROUP (US)
00:A0:2D 1394 Trade Association (US)
...


This file is **sorted by company name** and includes both the official IEEE OUI list and additional OUIs from custom sources. The **update date** is included at the top of the file.

You can use `oui.txt` in your projects freely — it is ideal for **network analysis, MAC address lookup, and other networking applications**.

---

## Update_OUI_from_iEEE.sh

`Update_OUI_from_iEEE.sh` is a Bash script that automates the process of updating your OUI file. It performs the following steps:

1. **Downloads** the latest IEEE OUI database.  
2. **Processes** it to extract MAC prefixes, company names, and country codes.  
3. **Downloads extra OUIs** from a custom source and appends them to the list.  
4. **Creates a clean `oui.txt`** file.  
5. **Sorts** the combined OUI list by company name and creates `oui-sorted.txt` with an update timestamp at the top.

---

### How to Use

1. Make the script executable:

```bash
chmod +x Update_OUI_from_iEEE.sh
./Update_OUI_from_iEEE.sh

Follow the menu options:

Option 1: Download and process the IEEE OUI + extra OUIs, then sort automatically.

Option 2: Sort an existing oui.txt file.

After running, you will have:

oui.txt — combined cleaned OUI list

oui-sorted.txt — same list, sorted by company name, with an update header

Example Usage in Projects

You can use oui-sorted.txt for:

MAC address lookup

Network device identification

Security auditing or penetration testing

Any project requiring mapping of MAC prefixes to companies
