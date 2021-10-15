# activate antigen
source /usr/local/share/antigen/antigen.zsh

# oh-my-zsh
antigen use oh-my-zsh

# git 
antigen bundle git
antigen bundle git-extras

# nvm 
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

# tmux 
ZSH_TMUX_AUTOSTART=true
antigen bundle tmux

# utilities 
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

# theme
antigen theme spaceship-prompt/spaceship-prompt
SPACESHIP_CHAR_SYMBOL="🦄 ~ "

# syntax highlighting - must be last plugin!
antigen bundle zsh-users/zsh-syntax-highlighting

# tell Antigen that we're done.
antigen apply

# hosts
if command grep -qc '#=====END SOMEONEWHOCARES=====#' /etc/hosts; then
  cat /etc/hosts | sed -e/=====END\ SOMEONEWHOCARES=====/\{ -e:1 -en\;b1 -e\} -ed  > $HOME/hosts.backup # backup any existing host file
  curl -fsSL "https://someonewhocares.org/hosts/hosts" > $HOME/hosts # download latest
  cat $HOME/hosts.backup >> $HOME/hosts # append the backup host file to the new host file
  cp $HOME/hosts /etc/hosts # make the new hosts file the default
  rm $HOME/hosts # remove, but keep the backup
fi

# locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
