#!/usr/bin/env bash
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.Preview ApplePersistenceIgnoreState -bool true
chflags nohidden ~/Library
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
killall Finder
