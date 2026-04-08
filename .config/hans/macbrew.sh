#!/usr/bin/env bash
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    echo 'Update zsh config with "eval $(/opt/homebrew/bin/brew shellenv)"'
fi

xargs -L1 brew install --cask < macapps.txt
xargs -L1 brew install < packages.txt
