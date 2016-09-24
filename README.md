# Maintentance
http://thoughtbot.github.io/rcm/lsrc.1.html

1. To restore from repository:
- `git clone git@github.com:rybycy/dotfiles.git`
- `cd dotfiles`
- `rcup -d . from this dir`

# Vim
1. install vundle
2. sudo apt-get install vim-nox for ruby support
3. mkdir .vim/backups && mkdir .vim/swaps
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## Top most powerful keystrokes
### Vanilla VIM
1. ciw/diw/caw/daw
2. mark some item with `m`
3. go to the latest position with `\`\``
4. repeating last command with `.` and macros!

### My additions
1. `Glastmsg` command - run this command while commiting to paste the last msg inside the text. Useful when you want to reuse some piece of information from the previous commit message (jira ticket number for instance)

### With plugins included in my configuration
1. nerdtree - 
- `ctrl + n` to toggle
- `ctrl + f` to show the current node
- inside the nerdtree hit `m` to show menu, where you can create a file or something
2. ctrlp - simply hit `ctrl + p` to search through current file's repository
3. Fugitive:
- `Gblame` - git blame. Hit `o` when blaming to see the full commit info
- `Glog` - loads all previous version of the file - `cprev`/`cnext`/`cfirst`/`clast` commands allow you to move between version freely
- `Gedit SHA` -
- `Gstatus` - git status in good looking

# Zsh 
1. GITIT - remember
2. bd - move up in the `pwd`
