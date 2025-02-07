#! /bin/env bash

set -e

if [ ! -f /usr/local/bin/clip.exe ]; then
    sudo ln -s /mnt/c/Windows/System32/clip.exe /usr/local/bin/clip.exe
fi
if [ ! -f /usr/local/bin/powershell.exe ]; then
    sudo ln -s /mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe /usr/local/bin/powershell.exe
fi
if [ ! -f /usr/local/bin/code ]; then
    sudo ln -s /mnt/c/Users/hans/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code /usr/local/bin/code
fi
if [ ! -f /usr/local/bin/chrome ]; then
    sudo ln -s /mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe /usr/local/bin/chrome
fi
