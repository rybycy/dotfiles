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

if [[ -n $SSH_CONNECTION ]]; then
  export PS1='%m:%3~$(git_info_for_prompt)%# '
else
  export PS1='%3~$(git_info_for_prompt)%# '
fi

source $ZSH/oh-my-zsh.sh

### Plugins
plugins=(git brew colorize cp github npm osx python scala vagrant alias-tips wd git-it-on zsh-maven-plugin zsh-syntax-highlighting)

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

function optimize_pdf {
	if [ -z "$1" ] && [ -z "$2" ]; then
		echo "Usage: optimize_pdf input_file output_file"
		return 1;
	fi
	sudo gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -sOutputFile=$2 "$1"
}

function dangerouslyReplaceInAllFilesRecursively {
	if [[ -z "$1" ]] && [[ -z "$2" ]]; then
		echo "Usage: dangerouslyReplaceInAllFiles <from> <to>"
		return 1;
	fi
	ack --print0 -l "$1" | xargs -0 perl -pi -E "s/$1/$2/g"
}

function diveIntoJar {
	jar="$1"
	# Loop through the classes (everything ending in .class)
	for class in $(jar -tf $jar | grep '.class'); do
		# Replace /'s with .'s
		class=${class//\//.};
		# javap
		javap -classpath $jar ${class//.class/};
	done
}

incl "macosx"
incl "bit"
incl "vostro"

# zsh-bd
. $HOME/.zsh/plugins/bd/bd.zsh

