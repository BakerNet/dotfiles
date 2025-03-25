#! /usr/bin/env bash

set -e

pushd /mnt/c > /dev/null 2>&1
username=$(/mnt/c/Windows/System32/cmd.exe /C "echo %USERNAME%" | tr -d '$\r')
popd > /dev/null 2>&1
echo "User: $username"

if [[ ! -f "/usr/local/bin/clip.exe" && -f "/mnt/c/Windows/System32/clip.exe" ]]; then
    sudo ln -s /mnt/c/Windows/System32/clip.exe /usr/local/bin/clip.exe
fi
if [[ ! -f "/usr/local/bin/powershell.exe" && -f "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe" ]]; then
    sudo ln -s /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe /usr/local/bin/powershell.exe
fi
if [[ ! -f "/usr/local/bin/code" && -f "/mnt/c/Users/$username/AppData/Local/Programs/Microsoft VS Code/bin/code" ]]; then
    sudo ln -s /mnt/c/Users/hans/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code /usr/local/bin/code
fi
if [[ ! -f "/usr/local/bin/cursor" && -f "/mnt/c/Users/$username/AppData/Local/Programs/cursor/Cursor.exe" ]]; then
    sudo ln -s /mnt/c/Users/hans/AppData/Local/Programs/cursor/Cursor.exe /usr/local/bin/cursor
fi
if [[ ! -f "/usr/local/bin/chrome" && -f "/mnt/c/Program Files/Google/Chrome/Application/chrome.exe" ]]; then
    sudo ln -s /mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe /usr/local/bin/chrome
fi
