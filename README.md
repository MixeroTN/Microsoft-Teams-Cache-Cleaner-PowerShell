# Microsoft Teams Cache Cleaning Script

[![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)](#---)
[![Teams](https://img.shields.io/badge/Microsoft_Teams-6264A7?style=for-the-badge&logo=microsoft-teams&logoColor=white)](#---)
[![PowerShell](https://img.shields.io/badge/powershell-5391FE?style=for-the-badge&logo=powershell&logoColor=white)](#---)
[![License](https://img.shields.io/badge/LICENSE-MIT-brightgreen?style=for-the-badge)](https://opensource.org/licenses/MIT)

This is a PowerShell script that is designed to clean the cache of Microsoft Teams by killing the `teams.exe` process if active, cleaning a cache and asking the user if they want to launch Teams again.

⚠️ **Script requires administrator privileges to run.**

## Usage
- Launch `clearTeams.ps1`
- Grant administrator privileges
- The script will close any active Teams process and clear the Teams cache
- The script will then prompt the user if they want to launch Teams again

## Script Explanation

The script starts by checking if the current user has administrator privileges. If not, it will ask for administrator privileges.

The script then closes the Teams process if it's active, and clears the Teams cache. The Teams cache is located in the following directories:

    APPDATA\Microsoft\Teams\Cache
    APPDATA\Microsoft\Teams\blob_storage
    APPDATA\Microsoft\Teams\databases
    APPDATA\Microsoft\Teams\gpucache
    APPDATA\Microsoft\Teams\Indexeddb
    APPDATA\Microsoft\Teams\Local Storage
    APPDATA\Microsoft\Teams\tmp

Finally, the script prompts the user if they want to launch Teams again. If the user chooses to launch Teams, the script will start the Teams process again.
