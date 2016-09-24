# run tmux by default
if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi

export ZSH=~/.oh-my-zsh
export TERM="xterm-256color"
export SPARK_HOME=/usr/local/spark
export PATH=$PATH:/usr/local/spark/bin

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="agnoster"

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

mkcd() { mkdir $1; cd $1; }

function optimize_pdf {
	if [ -z "$1" ] && [ -z "$2" ]; then
		echo "Usage: optimize_pdf input_file output_file"
		return 1;
	fi
	sudo gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -sOutputFile=$2 "$1"
}

# replace content of the current dir $1 with $2 in all files recursively
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

if [[ $OSTYPE == *"darwin"* ]] 
then
	[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
fi
. $HOME/.zsh/plugins/bd/bd.zsh
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
