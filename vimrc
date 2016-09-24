syntax on
let mapleader=','

set nocompatible			" be iMproved, required
set laststatus=2			" always show the status line
set number				" show line number at the beginning of each line
if has('mouse')
	set mouse=a
	" set ttymouse=xterm2
endif
set incsearch				" show search results while typing
set ignorecase				" ignore case in pattern...
set smartcase				" ... but still search for uppercase only even if the ignorecase option was set
set hlsearch				" highlight search matches
set autoindent				" use indent for new line
set smartindent			
set smarttab
set tabstop=8
set shiftwidth=8
set softtabstop=8
set wildmenu				" completion
set wildmode=list:longest		" completion
set gdefault				" Add the g flag to search/replace by default
set hidden
set history=1000
set diffopt+=vertical			" split vertically, e.g. when diffing
set backspace=indent,eol,start		" Allow backspace in insert mode
set autoread				" autoread modified files
set foldmethod=syntax			" fold based on indent
set ttyfast				" faster redrawing
if (has("termguicolors"))
	set termguicolors
endif

" make comments and HTML attributes italic
highlight Comment cterm=italic
highlight htmlArg cterm=italic

" show white chars and be able to toggle this mode quickly
set list
set listchars=tab:→\ ,trail:♣,extends:❯,precedes:❮
map <C-k> :set list!<CR> " toggle whitespaces highlighting

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" this is not a good idea to open NTree by default
" because it opens even it's completely not needed - it's better to 
map <C-l> :Limelight<CR>		" toggle limelight
map <C-n> :NERDTreeToggle<CR>		" ctrl + n opens nerdtree
map <C-f> :NERDTreeFind<CR>		" ctrl + f finds in nerdtree
map <C-t> :tabnew<CR>			" CTRL + t opens new tab
map <C-`> :tabNext<CR>			" CTRL + ` goes to next tab

let g:ctrlp_working_path_mode = 'c'	" search down the current dir

filetype off				" required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" http://vimawesome.com/
Plugin 'gmarik/Vundle.vim'
Plugin 'L9' 

Plugin 'maciakl/vim-neatstatus'		" beautiful status line
Plugin 'vimwiki/vimwiki'		" vim wiki
Plugin 'tpope/vim-surround'		" parenthesizing
Plugin 'kien/ctrlp.vim'			" smart file finding with CTRL+P
Plugin 'altercation/vim-colors-solarized' " colour scheme
Plugin 'scrooloose/syntastic'		" syntax checking
Plugin 'scrooloose/nerdcommenter'	" provides <leader>(cc|c<space>) for commenting
Plugin 'scrooloose/nerdtree'		" file tree
Plugin 'ervandew/supertab'		" insert mode completions with tab
Plugin 'godlygeek/tabular'		" text alignment
Plugin 'sickill/vim-pasta'		" content-aware pasting
Plugin 'junegunn/limelight.vim'		" hyperfocus writing in vim

Plugin 'tpope/vim-fugitive'		" git wrapper - provides :G_ commands
Plugin 'airblade/vim-gitgutter'		" git diff in sidebar

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

function! JscsFix()
    "Save current cursor position"
    let l:winview = winsaveview()
    "Pipe the current buffer (%) through the jscs -x command"
    % ! jscs -x
    "Restore cursor position - this is needed as piping the file"
    "through jscs jumps the cursor to the top"
    call winrestview(l:winview)
endfunction
command! JscsFix :call JscsFix()


function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

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
endif

" Syntastic confinguration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm,*.nunj set filetype=jinja " use ninja highlighting on e.g. nunj templates

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set background=dark
colorscheme solarized

" Quick guide
" Most interesting vim features
"	g~, U, u - toggle case of characters
"	ddkP - switch current line with previous
"
" Best features included in plugins
"	<leader> hp, hs, hu - chunk preview, stage, undo - git
"	<leader> c <space> - toggle comment
"
