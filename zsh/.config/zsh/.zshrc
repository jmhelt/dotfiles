export ZSH="$ZDOTDIR/oh-my-zsh"
ZSH_THEME=""

plugins=(git ssh-agent sudo)

# zsh-autocomplete must be sourced before oh-my-zsh calls compinit
source $ZDOTDIR/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

source $ZSH/oh-my-zsh.sh

source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source $ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# zsh-syntax-highlighting must be sourced last
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

fpath+=($ZDOTDIR/pure)
autoload -U promptinit
promptinit
prompt pure

export LANG=en_US.UTF-8
export EDITOR=vim

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
