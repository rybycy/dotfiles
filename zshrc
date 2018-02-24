# run tmux by default
#if command -v tmux>/dev/null; then
#  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux a
#fi

export ZSH=~/.oh-my-zsh
export TERM="xterm-256color"
export SPARK_HOME=/usr/local/spark
export SCALA_HOME=/usr/share/scala
export PATH=$PATH:$SCALA_HOME/bin:$SPARK_HOME/bin
export JAVA_HOME=$(readlink /usr/bin/java | sed "s:bin/java::")

# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="agnoster"

DEFAULT_USER='rybycy'

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

function ssht() {
	ssh $1 -t tmux -2 a
}
### Plugins
plugins=(git
	brew		# brew completion
	colorize	# colorize file's content
	npm		# npm autocompletion
	python		# python interpreter completion
	scala		# scala/scalac completion
	vagrant		# vagrant autocompletion
	wd		# add tags to directory
	git-it-on	# go to github of current repo
	mvn		# maven completion
	zsh-syntax-highlighting)

function optimize_pdf {
	if [ -z "$1" ] && [ -z "$2" ]; then
		echo "Usage: optimize_pdf input_file output_file"
		return 1;
	fi
	sudo gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -sOutputFile=$2 "$1"
}

alias GIT_SORRY_I_AM_VERY_STUPID="git reset 'HEAD@{1}'"
alias AWS_KICK_PUPPET="ssh h226636@10.66.32.21 'sudo puppet agent -t' && ssh h226636@10.66.12.100 'sudo puppet agent -t'"

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

alias skag="sk --ansi -i -c 'ag --color \"{}\"'"
alias skvim="vim -p \$(sk -m)"

function movToWebm {
    #brew install ffmpeg --with-libvpx
    src="$1"
    target="$2"
    ffmpeg -i "$src" -c:v libvpx -crf 10 -b:v 1M -c:a libvorbis "$target"
}

if [[ $OSTYPE == *"darwin"* ]]
then
	[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
    alias cpwd="pwd | pbcopy"
    alias ccommand="echo !! | pbcopy"
    # alias cfile
else
	[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh
	autoload -U compinit && compinit -u
    alias ccommand="echo !! | xcopy" # todo
fi
. $HOME/.zsh/plugins/bd/bd.zsh

[[ -s "$HOME/.qfc/bin/qfc.sh"  ]] && source "$HOME/.qfc/bin/qfc.sh"

source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
DISABLE_AUTO_TITLE=true

function findTotalSize {
    find $@ -exec du -ch {} + | grep total$
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias bit_lscs_proxy='ssh -L 1876:localhost:1876 h226636@10.66.12.65'

alias st="open -a \"Sublime Text\""
export PATH="/usr/local/opt/expat/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
