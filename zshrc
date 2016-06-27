export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

alias python=python3

if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

source $ZSH/oh-my-zsh.sh

### Plugins
plugins=(git brew colorize cp github npm osx python scala vagrant zsh-syntax-highlighting alias-tips wd git-it-on zsh-maven-plugin)

### Aliases
alias pls='sudo'

#jump below
jd(){
    if [ -z "$1" ]; then
        echo "Usage: jd [directory]";
        return 1
    else
        cd **"/$1"
    fi
}

mkcd() { mkdir $1; cd $1; }

function incl {
	FILE=~/.zshrc_includes/.zshrc_$1
	if [ -f $FILE ]
	then
		source $FILE
	fi
}

incl "macosx"
incl "bit"
incl "vostro"

# zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh
