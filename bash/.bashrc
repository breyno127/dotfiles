# -*- mode: sh -*-

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# stop macOS from telling me to switch zsh
export BASH_SILENCE_DEPRECATION_WARNING=1

# setup cdpath
export CDPATH=.:$HOME/code

# Postgres
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

# Path for homebrew (/usr/local/[s]bin)
PATH=/usr/local/bin:/usr/local/sbin:$PATH

# Setup chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Setup pyenv
if which pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

green="\[\033[0;32m\]"
blue="\[\033[0;34m\]"
purple="\[\033[0;35m\]"
reset="\[\033[0m\]"

# Change command prompt
export GIT_PS1_SHOWDIRTYSTATE=1
# '\u' adds the name of the current user to the prompt
# '\$(__git_ps1)' adds git-related stuff
# '\W' adds the name of the current directory
export PS1="$purple\u$blue \w$green\$(__git_ps1) \n$ $reset"

# Aliases
alias be='bundle exec'
alias emacsc='emacsclient -tty'

# asdf version manager
. $(brew --prefix asdf)/asdf.sh
. $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

# gpg

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi

blowport() {
    lsof -ti tcp:$1 | xargs kill
}

export PATH="$HOME/.cargo/bin:$PATH"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion