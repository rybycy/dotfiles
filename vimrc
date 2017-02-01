syntax on
let mapleader=' '

set nocompatible			" be iMproved, required
set laststatus=2			" always show the status line
set relativenumber			" show line number at the beginning of each line
if has('mouse')
	set mouse=a
endif
set incsearch				" show search results while typing
set ignorecase				" ignore case in pattern...
set smartcase				" ... but still search for uppercase only even if the ignorecase option was set
set hlsearch				" highlight search matches
set autoindent				" use indent for new line
set smartindent
set smarttab
set tabstop=4                           " number of spaces equal to tab
set shiftwidth=4                        " number of spaces used for intendation
set expandtab				" replace tabs with spaces when indenting
set wildmenu				" completion
set wildmode=list:longest		" completion
set gdefault				" Add the g flag to search/replace by default
set hidden
set history=1000
set diffopt+=vertical			" split vertically, e.g. when diffing
set backspace=indent,eol,start		" Allow backspace in insert mode
set autoread				" autoread modified files
set foldmethod=manual			" fold based on indent
set ttyfast				" faster redrawing

" use ag instead of ack as a grepping tool
let g:ackprg = 'ag --nogroup --nocolor --column'

" make comments and HTML attributes italic
highlight Comment cterm=italic
highlight htmlArg cterm=italic

" show white chars and be able to toggle this mode quickly
set list
set listchars=tab:→\ ,trail:♣,extends:❯,precedes:❮
nnoremap <Leader>tw :set list!<CR>              " toggle whitespaces highlighting
nnoremap <Leader>lx :%!xmllint --format -       "lint xml

nnoremap <Leader>w :w<CR>                       " save file shortcut

"copy and paste to system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap <Leader>sh :split<CR>                  " split horizontally
nnoremap <Leader>sv :vsplit<CR>                 " split vertically

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" Limelight config
map <Leader>tl :Limelight!!<CR>		" toggle limelight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'


" this is not a good idea to open NTree by default
" because it opens even it's completely not needed - it's better to
map <C-n> :NERDTreeToggle<CR>		" ctrl + n opens nerdtree
map <leader>sf :NERDTreeFind<CR>		" ctrl + f finds in nerdtree
map <F2> :retab <CR> :wq! <CR>

" tabs options
map <C-t> :tabnew<CR>			" CTRL + t opens new tab
map <C-`> :tabNext<CR>			" CTRL + ` goes to next tab

let g:ctrlp_working_path_mode = 'c'	" search down the current dir

filetype off				" required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" http://vimawesome.com/
Plugin 'gmarik/Vundle.vim'
Plugin 'L9'

Plugin 'altercation/vim-colors-solarized' " colour scheme

Plugin 'maciakl/vim-neatstatus'		" beautiful status line
Plugin 'vimwiki/vimwiki'		    " vim wiki
Plugin 'tpope/vim-surround'		    " parenthesizing - provides super useful keystroke of `ysiw[` which wraps current word in []
Plugin 'kien/ctrlp.vim'			    " smart file finding with CTRL+P
Plugin 'scrooloose/syntastic'		" syntax checking
Plugin 'scrooloose/nerdcommenter'	" provides <leader>(cc|c<space>) for commenting
Plugin 'scrooloose/nerdtree'		" file tree
Plugin 'ervandew/supertab'	    	" insert mode completions with tab
Plugin 'godlygeek/tabular'		    " text alignment
Plugin 'sickill/vim-pasta'		    " content-aware pasting
" Plugin 'junegunn/limelight.vim'		" hyperfocus writing in vim
Plugin 'mileszs/ack.vim'		    " ack for vim
Plugin 'terryma/vim-expand-region'
Plugin 'tpope/vim-fugitive'     " git wrapper - provides :G_ commands
Plugin 'airblade/vim-gitgutter' " git diff in sidebar

Plugin 'lervag/vimtex'          " LateX support

" prog
" frontend
Plugin 'lepture/vim-jinja'
Plugin 'othree/html5.vim'
Plugin 'gregsexton/MatchTag'		" match tags in html

Plugin 'pangloss/vim-javascript'
Plugin 'gavocanov/vim-js-indent'
Plugin 'othree/es.next.syntax.vim'
Plugin 'mxw/vim-jsx'

Plugin 'klen/python-mode'
Plugin 'derekwyatt/vim-scala'

Plugin 'elzr/vim-json'
Plugin 'plasticboy/vim-markdown'

call vundle#end()			" required

filetype plugin indent on
filetype plugin on
set omnifunc=syntaxcomplete#Complete

function Glastmsg()
	read !git lastmsg
endfunction
command! Glastmsg all Glastmsg()

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	" Treat .md files as Markdown
	autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
	autocmd BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm,*.nunj set filetype=jinja " use ninja highlighting on e.g. nunj templates
endif

" Syntastic confinguration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:javascript_plugin_jsdoc = 1 " configure javascript plugin

set background=dark
" :set t_Co=256
" let g:solarized_termcolors=256
colorscheme solarized

" Fat-fingers, halp, halp!
:command WQ wq
:command Wq wq
:command Wqa wqa
:command W w
:command Q q
:command QA qa
:command Qa qa
