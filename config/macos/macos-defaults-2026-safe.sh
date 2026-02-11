#!/usr/bin/env bash

set -euo pipefail

# macOS defaults profile (2026-safe baseline)
# This keeps the spirit of your old profile while avoiding risky/obsolete tweaks.
# Topic labels:
# [Cosmetic] look and feel
# [Performance] speed/health/battery
# [Efficiency] workflow and shortcuts
# [Hack] non-standard tweak

osascript -e 'tell application "System Settings" to quit' || true
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# Global UI/UX
###############################################################################

# [Cosmetic] lower visual noise
defaults write com.apple.universalaccess reduceTransparency -bool true

# [Cosmetic] always show scroll bars for stable visual anchors
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# [Efficiency] make open/save and print dialogs show full options
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# [Efficiency] local-first save location
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# [Efficiency] avoid smart punctuation/capitalization/autocorrect in code-heavy use
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# [Hack] security hardening: keep Gatekeeper quarantine prompts enabled
defaults write com.apple.LaunchServices LSQuarantine -bool true

###############################################################################
# Input devices and keyboard
###############################################################################

# [Efficiency] tap to click and secondary click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# [Efficiency] full keyboard navigation in dialogs
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# [Efficiency] key repeat optimized for editing
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

###############################################################################
# Power and battery
###############################################################################

# [Performance] display sleep after 10 minutes
sudo pmset -a displaysleep 10

# [Performance] allow machine sleep on battery and charger
sudo pmset -b sleep 15
sudo pmset -c sleep 20

# [Performance] safe hibernation defaults for laptops
sudo pmset -a hibernatemode 3

# [Performance] keep lid wake and auto-restart after power loss
sudo pmset -a lidwake 1
sudo pmset -a autorestart 1

###############################################################################
# Screenshots and screen lock
###############################################################################

# [Efficiency] require password immediately on lock/sleep
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# [Efficiency] tidy screenshot defaults
mkdir -p "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder
###############################################################################

# [Efficiency] information density and file clarity
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# [Performance] avoid writing Finder metadata to external/network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# [Efficiency] reveal useful hidden locations
chflags nohidden "${HOME}/Library" || true
sudo chflags nohidden /Volumes || true

###############################################################################
# Dock and Spaces
###############################################################################

# [Cosmetic] compact dock; [Efficiency] fast behavior
defaults write com.apple.dock tilesize -int 40
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.12
defaults write com.apple.dock expose-group-by-app -bool false
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.12
defaults write com.apple.dock showhidden -bool true
defaults write com.apple.dock show-recents -bool false

# [Efficiency] hot corners
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari
###############################################################################

# [Efficiency] keyboard-friendly browsing and cleaner URL bar
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
defaults write com.apple.Safari HomePage -string "about:blank"

# [Performance] prevent auto-opening downloads
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# [Hack] developer tooling
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# [Efficiency] reduce typing surprises
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# [Performance] secure defaults
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
defaults write com.apple.Safari WebKitPluginsEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false
defaults write com.apple.Safari WebKitJavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false

###############################################################################
# Spotlight
###############################################################################

# [Efficiency] focused Spotlight categories
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
killall mds >/dev/null 2>&1 || true

###############################################################################
# Terminal and iTerm
###############################################################################

# [Efficiency] UTF-8 and secure input
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.terminal SecureKeyboardEntry -bool true
defaults write com.apple.Terminal ShowLineMarks -int 0
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

###############################################################################
# Software update and backups
###############################################################################

# [Performance] stay current on security and app updates
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1
defaults write com.apple.commerce AutoUpdate -bool true
defaults write com.apple.commerce AutoUpdateRestartRequired -bool false

# [Efficiency] avoid backup prompts for random external drives
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# App-specific quality-of-life
###############################################################################

# [Efficiency] Mail ergonomics
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\U21a9"

# [Efficiency] Messages predictability
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

# [Efficiency] Chrome accidental navigation guard
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

###############################################################################
# Reload common apps
###############################################################################

for app in "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" "Terminal"; do
  killall "${app}" >/dev/null 2>&1 || true
done

echo "Done. Some changes still require logout or restart."
