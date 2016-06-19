export ZSH=/home/rybycy/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

plugins=(git brew colorize cp github npm osx python scala vagrant)

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

### Aliases
alias pls='sudo'

### Custom functions 
# UP TO FOLDER
up() {
    if [ -z "$1" ]; then
        return
    fi
    local up=$1
    cd "${PWD/\/$up\/*//$up}"
}

_up() {
    local cur=${COMP_WORDS[COMP_CWORD]}
    local d=${PWD//\//\ }
    COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
complete -F _up up

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
source $ZSH/oh-my-zsh.sh
