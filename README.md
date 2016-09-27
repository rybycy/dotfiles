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
1. {y,c,d}{i,a}{w,t,p}
{yank,change,delete}{inner,all}{word,tag,paragraph}
2. mark some item with `m` - simply hit `m` and then `letter` and then it's possible to go back to this place with `\` + letter`
3. use `ctrl+a` and `ctrl+x` to increase/decrease counters in your text.
4. go to the latest position with `\`\``
5. repeating last command with `.` and macros! *TODO* it should be browser throughroughly
6. `g~, gU, gu` to toggle/upper/lower the case
7. Use `f` to find a character in current line
8. Move your cursor to the top, mid and bottom of the screen with respectively `H, M, L` keys in normal mode
9. Copy something to register with simply `"<register>yy` and then paste with `"<register>p"`
- awesome shortcut - when in INSERT mode just hit `ctrl + r` and `<register>` to simply paste register's value, use `<ctrl> + a` to paste the last one.
10. Use completion modes. Hit ctrl + x and then:
- ctrl + l to complete whole lines for file
- ctrl + p to complete words
- ctrl + f to complete filenames
- ctrl + o for omnicompletion `<li>abc</` and then omnicompletion will close html tag
- ctrl + n for keywords in current file
11. `za`/`zc`/`zo` to toggle/close/open folding

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
- `ysw"` for example wraps current word with `""`
- `cs"'` from inner quote to change surrounding from `"` to `'`
- `cst<xyz>` replaces current surrounding tag with new `<xyz>`
- `S<tag>` from visual mode to wrap selected items in <tag>
5. nerdcommenter:
- `<leader>c<space>` to toggle the comment
6. ack.vim:
- `:Ack <phrase> <dir>` - dir defaults to current if absent
- `t` - open in new tab

# Zsh 
## Installation
1. git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
2. git clone https://github.com/peterhurford/git-it-on.zsh ~/.oh-my-zsh/custom/plugins/git-it-on
3. pip install pygments #to make colorize plugin work
4. git clone https://github.com/wting/autojump.git && cd autojump && chmod +x install.py && python install.py

## Usage
1. bd - move up in the `pwd`
2. gitit - open current repo's github
3. `colorize <file> | less` to get colorized file output
4. autojump - allows to quickly search through visited (at least once) directories. Just type `j <partial_filename>` to see list of possible files/dirs
5. `wd` adds tags to directory so after `wd add <dir_name>` in some directory you can do `wd <dir_name>` to immediately jump to this dir
MORE?

# tmux
- All hotkeys visible via `ctrl + ?`
- `Ctrl+b` is a prefix on a host machine
- `Ctrl+j` is a prefix on a remote machine
- Most useful ones:
- - `n`/`p` go to to next/previous window
- - `<number>` to go to specified window
- - `attach`/`detach`
- - `c` to create a window
- - `}` to swap windows
- - `<right>`/`<left>` to move between panes
- - `%` / `"` to split windows with panes - horizontally/vertically

In order to use a config, e.g. for rpi:
1. `scp ~/.rpi.tmux.conf pi@raspberrypi:~/.tmux.conf`
2. `ssh pi@raspberrypi -t tmux -2 a` 
