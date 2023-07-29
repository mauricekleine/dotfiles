# activate antigen
source $(brew --prefix)/share/antigen/antigen.zsh

# oh-my-zsh
antigen use oh-my-zsh

# git 
antigen bundle git

# nvm 
export NVM_AUTO_USE=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
antigen bundle lukechilds/zsh-nvm

# tmux (only run in interactive shell)
if [[ -t 1 ]]; then
  ZSH_TMUX_AUTOSTART=true
  antigen bundle tmux
fi

# utilities 
antigen bundle zsh-users/zsh-autosuggestions

# theme
antigen theme spaceship-prompt/spaceship-prompt
SPACESHIP_CHAR_SYMBOL="🦄 $ "	
SPACESHIP_PROMPT_ORDER=(
  # time        # Time stamps section 
  # user        # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  # hg          # Mercurial section (hg_branch  + hg_status)
  # package     # Package version
  node          # Node.js section
  # ruby        # Ruby section
  # elixir      # Elixir section
  # xcode       # Xcode section 
  # swift       # Swift section
  # golang      # Go section
  # php         # PHP section
  # rust        # Rust section
  # haskell     # Haskell Stack section
  # julia       # Julia section 
  # docker      # Docker section 
  # aws         # Amazon Web Services section
  # gcloud      # Google Cloud Platform section
  # venv        # virtualenv section
  # conda       # conda virtualenv section
  # pyenv       # Pyenv section
  # dotnet      # .NET section
  # ember       # Ember.js section 
  # kubectl     # Kubectl context section
  # terraform   # Terraform workspace section
  # ibmcloud    # IBM Cloud section
  exec_time     # Execution time
  line_sep      # Line break
  # battery       # Battery level and status
  # vi_mode     # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# syntax highlighting - must be last plugin!
antigen bundle zsh-users/zsh-syntax-highlighting

# tell Antigen that we're done.
antigen apply

# locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# pnpm
export PNPM_HOME="/Users/maurice/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# github copilot cli
eval "$(github-copilot-cli alias -- "$0")"

