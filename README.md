# Microsoft Teams Cache Cleaning Script (Windows)

This is a PowerShell script that is designed to clean the cache of Microsoft Teams by killing the `teams.exe` process if active, cleaning a cache and asking the user if they want to launch Teams again.

Note: This script requires administrator privileges to run.

## Usage
    Launch the script
    Grant administrator privileges
    The script will close any active Teams process and clear the Teams cache
    The script will then prompt the user if they want to launch Teams again

## Script Explanation

The script starts by checking if the current user has administrator privileges. If not, it will prompt the user to run the script with administrator privileges.

The script then closes the Teams process if it's active, and clears the Teams cache. The Teams cache is located in the following directories:

    $env:APPDATA\Microsoft\Teams\Cache
    $env:APPDATA\Microsoft\Teams\blob_storage
    $env:APPDATA\Microsoft\Teams\databases
    $env:APPDATA\Microsoft\Teams\gpucache
    $env:APPDATA\Microsoft\Teams\Indexeddb
    $env:APPDATA\Microsoft\Teams\Local Storage
    $env:APPDATA\Microsoft\Teams\tmp

Finally, the script prompts the user if they want to launch Teams again. If the user chooses to launch Teams, the script will start the Teams process again.
