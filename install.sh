# Losely based on https://github.com/atomantic/dotfiles

##########################################################################################
# SUDO
##########################################################################################

# Go sudo
sudo -v

# Keep-alive: update existing sudo time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

##########################################################################################
# BREW
##########################################################################################

# update brew
brew update
# updates brew packages
brew upgrade

# install new packages
brew install git tmux zsh
brew install yarn --without-node

##########################################################################################
# ZSH / OH MY ZSH
##########################################################################################

# set zsh as default shell
sudo chsh -s $(which zsh)
sudo dscl . -change /Users/$USER UserShell $SHELL /usr/local/bin/zsh > /dev/null 2>&1

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install custom thme
cp ./fudge.zsh-theme $HOME/.oh-my-zsh/custom/themes

##########################################################################################
# DOTFILES
##########################################################################################

pushd dotfiles > /dev/null 2>&1

for file in .*; do
  if [[ $file == "." || $file == ".." ]]; then
    continue
  fi
    cp $file ~/
done

popd > /dev/null 2>&1

##########################################################################################
# SECURITY
##########################################################################################

# turn firewall on for specific services and enable stealth mode
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 1

# disable guest account
sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false

##########################################################################################
# SYSTEM
##########################################################################################

# activate 'locate'
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist > /dev/null 2>&1

##########################################################################################
# NVM
##########################################################################################

# install nvm
sh -c "$(curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh)"

# source .zshrc which has nvm path in it
source $HOME/.zshrc

# install latest stable node version
nvm install stable

# echo latest stable node version
node -v

##########################################################################################
# ITERM
##########################################################################################

open "solarized-dark.itermcolors"

echo "done!"
