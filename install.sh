##########################################################################################
# ENTER SUDO
##########################################################################################

# Go sudo
sudo -v

# Keep-alive: update existing sudo time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

##########################################################################################
# BREW
##########################################################################################

# install brew
brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  brew update
fi

# bundle
brew upgrade
brew bundle

##########################################################################################
# DOTFILES
##########################################################################################

stow --verbose --target=$HOME --restow */

##########################################################################################
# SECURITY
##########################################################################################

# turn firewall on for specific services and enable stealth mode
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1

# disable guest account
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable remote login
sudo systemsetup -setremotelogin off

##########################################################################################
# SYSTEM
##########################################################################################

# activate 'locate'
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist > /dev/null 2>&1

# running "Set computer name (as done via System Preferences → Sharing)"
sudo scutil --set ComputerName "maurice"
sudo scutil --set HostName "maurice"
sudo scutil --set LocalHostName "maurice"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "maurice"

# disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# running "Stop iTunes from responding to the keyboard media keys"
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

# require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# prevents resizing the dock
defaults write com.apple.Dock size-immutable -bool true

# empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# show all files in finder
defaults write com.apple.finder AppleShowAllFiles YES

##########################################################################################
# PROJECTS FOLDER
##########################################################################################

[ ! -d "~/Projects" ] && mkdir ~/Projects

##########################################################################################
# HOSTS
##########################################################################################

cd ~/Projects
git clone https://github.com/StevenBlack/hosts.git
cd ~/Projects/hosts
pip3 install --user -r requirements.txt
python3 updateHostsFile.py --auto --extensions fakenews gambling porn --replace

##########################################################################################
# SSH
##########################################################################################

ssh-keygen -t ed25519 -C "hey@mauricekleine.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

##########################################################################################
# GPG
##########################################################################################

gpg --full-generate-key
git config --global commit.gpgsign true

##########################################################################################
# FIN
##########################################################################################

echo "done!"
