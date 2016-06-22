syntax on
let mapleader=','

set nocompatible              " be iMproved, required
set laststatus=2
set showcmd
set showmode
set number
set mouse=a
set incsearch
set ignorecase
set smartcase
set hlsearch
set autoindent
set smartindent
set smarttab
set tabstop=8
set shiftwidth=8
set softtabstop=8
set wildmenu
set wildmode=list:longest

nmap <leader>ne :NERDTree<cr>
" Allow backspace in insert mode
set backspace=indent,eol,start

" Add the g flag to search/replace by default
set gdefault
set hidden
set history=1000
set diffopt+=vertical " we want more likely to split vertically, e.g. when diffing
let g:syntastic_javascript_checkers = ['jscs'] " set default javascript checker

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed

" this is not a good idea to open NTree by default
" because it opens even it's completely not needed - it's better to have
" toggle shortcut
" au VimEnter *  NERDTree " Open NERDTree by default
map <C-n> :NERDTreeToggle<CR> " CTRL + N opens nerdtree

filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" http://vimawesome.com/
Plugin 'gmarik/Vundle.vim'
Plugin 'L9' 

Plugin 'tpope/vim-surround' " parenthesizing
Plugin 'git://git.wincent.com/command-t.git' " smart file finding 
Plugin 'altercation/vim-colors-solarized' " colours, yeah
Plugin 'scrooloose/syntastic' " syntax checking
Plugin 'scrooloose/nerdcommenter' " commenting
Plugin 'scrooloose/nerdtree' " file tree
Plugin 'ervandew/supertab' "insert mode completions with tab
Plugin 'mileszs/ack.vim' "plugin for ack
Plugin 'honza/vim-snippets' "snippets

Plugin 'tpope/vim-fugitive' " git wrapper
Plugin 'airblade/vim-gitgutter' " git diff in sidebar

Plugin 'klen/python-mode'
Plugin 'derekwyatt/vim-scala'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'othree/html5.vim'
Plugin 'elzr/vim-json'

call vundle#end()            " required

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
let g:syntastic_javascript_checkers = ['jscs']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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
