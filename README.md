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

## Top most powerful keystrokes
### Vanilla VIM
1. ciw/diw/caw/daw
2. ddkp to swap the lines
3. mark some item with `m` - simply hit `m` and then `letter` and then it's possible to go back to this place with `\` + letter`
4. go to the latest position with `\`\``
5. repeating last command with `.` and macros!
6. `g~, gU, gu` to toggle/upper/lower the case
7. Use `f` to find a character in current line
8. Move your cursor to the top, mid and bottom of the screen with respectively `H, M, L` keys in normal mode


### My additions
1. `Glastmsg` command - run this command while commiting to paste the last msg inside the text. Useful when you want to reuse some piece of information from the previous commit message (jira ticket number for instance)
2. `<leader>ss` to remove redundant trailing spaces all over the document

### With plugins included in my configuration
1. nerdtree -
- `ctrl + n` to toggle
- `ctrl + f` to show the current node
- inside the nerdtree hit `m` to show menu, where you can create a file or something
2. ctrlp - simply hit `ctrl + p` to search through current file's repository
- `ctrl + d` to enter filename-only search
- `ctrl + t` to open a selection in a new tab
- `ctrl + x or v` to open a selection in a new split
3. fugitive:
- `Gblame` - git blame. Hit `o` when blaming to see the full commit info
- `Glog` - loads all previous version of the file - `cprev`/`cnext`/`cfirst`/`clast` commands allow you to move between version freely
- `Gedit SHA` -
- `Gstatus` - git status in good looking
4. vim-surround:
- `ysiw"` for example wraps current word with `""`
- `cs"'` from inner quote to change surrounding from `"` to `'`
- `S<tag>` from visual mode to wrap selected items in <tag>
5. nerdcommenter:
- `<leader>c<space>` to toggle the comment


# Zsh 
1. git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
2. GITIT - remember
3. bd - move up in the `pwd`

# tmux
- `Ctrl+b` is a prefix on a host machine
- `Ctrl+j` is a prefix on a remote machine

In order to use a config, e.g. for rpi:
1. `scp ~/.rpi.tmux.conf pi@raspberrypi:~/.tmux.conf`
2. `ssh pi@raspberrypi -t tmux -2 a` 
