# Maintentance
http://thoughtbot.github.io/rcm/lsrc.1.html

1. To restore from repository:
- `git clone git@github.com:rybycy/dotfiles.git`
- `cd dotfiles`
- `rcup -d . from this dir`

# Vim
## Prerequisites
1. install vundle
2. sudo apt-get install vim-nox for ruby support
3. mkdir .vim/backups && mkdir .vim/swaps


## Keystrokes
### Vanilla VIM
1. `{y,c,d}{i,a}{w,t,p}` = `{yank,change,delete}{inner,all}{word,tag,paragraph}`
2. you can `m(<sub>ark</sub>)` items in order to return to them later - simply hit `m` and then `letter` and then it's possible to go back to this place with `\` + letter`
3. use `ctrl+a(dd)` and `ctrl+x(tract)` to increase/decrease counters in your text.
4. go to the latest position with `` ` ` `` (two backticks)
5. repeating last command with `.` and macros!
- start recording with `q<register_letter>`. Invoke with `@<register_letter>`. `@@` invokes the latest macro
- hit `(ctrl + r) + =` in insert mode in order to enter an expression mode.
- write an expression, you can include your yanked content with `(ctrl + r) + "`. Useful when you need to increment or operate on some kind of a variable within the macro. 
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
12. In order to change all existing tab characters to match settings, run `:retab`
13. To unwrap something, e.g.
`([{foo: bar}]) -> {foo: bar}` just do:
- `ya}` to yank content of inner braces (inclusive)
- `va(` to select everything in `()` (inclusive)
- `p` to replace selected content with the yanked one
14. Replacement has some super features:
- `:%s//abc` will replace all occurences of your last search. Search with `/def` and then run `/%s//abc` to replace all `def`'s with `abc`'s
- use `g` flag to replace all in file occurences
- use `c` flag to confirm every replacement
- `:%s/\<foo\>/bar/gc` wrap words in `\<\>` in order to search for full words onyl
15. Use `ctrl + o(ut)`/`ctrl + i(n)` to go to previous/next file
16. `gv` in the visual mode returns to the latest selection
17. `ctrl + f/b` to move backward/forward a page; `ctrl + u/d` to go `up/down` half a page. `ctrl + e/y` to move without moving a cursor
18. `zz/zt/zb` to move screen and place cursor's position at `center/top/bottom`
19. You can escape insert mode with `ctrl + c` as well.
20. `X` in normal mode to remove character backwards.
21. `gi` puts you in insert mode in the last position you were while in insert mode.
22. use `:split` and `:vsplit` commands to split the screen horizontally/vertically
23. when you start editing multiple files with vim with e.g. `vim a.txt b.txt` you can navigate between them with `[a`/`]a` keys

### My additions
1. `Glastmsg` command - run this command while commiting to paste the last msg inside the text. Useful when you want to reuse some piece of information from the previous commit message (jira ticket number for instance)
2. `<leader>ss` to remove redundant trailing spaces all over the document
3. `<Leader>lx` to lint xml
4. `<Leader>sh` to split horizontally, `<Leader>sv` to split vertically

### With plugins included in my configuration
1. *nerdtree* -
- `ctrl + n` to toggle *n*erdtree
- `<leader>sf` to *s*how the current *f*ile (node in NerdTree)
- inside the nerdtree hit `m` to show menu, where you can create a file or something
2. *ctrlp* - simply hit `ctrl + p` to search through current file's repository
- `ctrl + d` to enter filename-only search
- `ctrl + t` to open a selection in a new tab
- `ctrl + x or v` to open a selection in a new split
3. *fugitive*:
- `Gblame` - git blame. Hit `o` when blaming to see the full commit info
- `Glog` - loads all previous version of the file - `cprev`/`cnext`/`cfirst`/`clast` commands allow you to move between version freely
- `Gedit SHA` -
- `Gstatus` - git status in good looking
4. *vim-surround*:
- `ysw"` for example wraps current word with `""`
- `cs"'` from inner quote to change surrounding from `"` to `'`
- `cst<xyz>` replaces current surrounding tag with new `<xyz>`
- `S<tag>` from visual mode to wrap selected items in <tag>
5. *nerdcommenter*:
- `<leader>c<space>` to toggle the comment
6. ack.vim:
- `:Ack <phrase> <dir>` - dir defaults to current if absent
- `t` - open in new tab

# General bash tips
## Movement
- `ctrl + a`/`ctrl + e` - *beginning/end* of the line
- `ctrl + k` - *delete* to the end of the line
- `ctrl + r`/`ctrl + s` - search *backward/forward*
- `ctrl + w` - *delete* the word behind the cursor

## Useful commands
- use `!$` to reuse last word of the last command.
- use `!!` to reuse last command
- `~-`/`~+` + `TAB` to show the list of recently entered dirs

## Tools
- pipe your file to `less` if it's too big to fit on screen. Use `head` or `tail` (or even `tail -f` to follow the end of the file) to see the specific part of the file
- `wc` to count lines, words or characters. Useful if you want to pipe things into `wc` in order to e.g. find the number of matching files from `find`
- `grep` allows you to search a string inside the files. `-r` for recursive search.
- use `ssh-copy-id` to copy your identity file to a remote host.

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
6. `take` to create a directory and change to it

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

# Tools
- use `cloc` application in order to reveal the number of lines of code in your project
