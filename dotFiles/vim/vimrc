" VIM configuration flo
call pathogen#infect()

" Disable compatibility with Vi
set nocompatible

" Display 
set title 
set number
set ruler
set wrap 

set scrolloff=3

" indent properly
set tabstop=2
set shiftwidth=2
set expandtab

set autoindent " Copy indent from last line when starting new line

set autoread " Set to auto read when a file is changed from the outside

" Search config
set ignorecase
set smartcase
set incsearch
set hlsearch  

" Beep
set visualbell
set noerrorbells

set cursorline
set colorcolumn=80

set backspace=indent,eol,start

set nocscopeverbose 

" new split appears below or right (feels more natural)
set splitbelow
set splitright

set nofoldenable

" always show status bar
set laststatus=2

set guifont=Source\ Code\ Pro\ For\ Powerline

syntax enable

" let g:solarized_termcolors=16
" set background=dark " dark|light "
colorscheme minimalist 

filetype plugin indent on
set encoding=utf-8
set t_Co=256

let mapleader="," 
nmap <silent> <Leader>of :FSHere<CR> 
nmap <silent> <Leader>or :FSSplitRight<CR> 

" NERDTree.
" ctrl-n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
"let g:NERDTreeDirArrowExpandable = '>'
"let g:NERDTreeDirArrowCollapsible = '<'

" CtrlP
" Ignore some folders and files for CtrlP indexing
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules)',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

"let g:ctrlp_map = ’<leader>c’
" Default parameters for ack
"let g:ackprg="ack -H --nocolor --nogroup --column" 
" Put a marker and search
"nmap <leader>j mA:Ack<space>
" Put a marker and search current word under cursor
"nmap <leader>j amA:Ack "<C-r>=expand("<cword>")<cr>"
"nmap <leader>j amA:Ack "<C-r>=expand("<cWORD>")<cr>"

" gitgutter settings
hi clear signColumn

" Airline settings
" show for tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#hunks#non_zero_only = 1
" use patched font
let g:airline_powerline_fonts = 1
" enable jsx syntax highlighting
let g:jsx_ext_required = 0
let g:airline_theme='minimalist'

cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

au BufRead,BufNewFile *.kt  set filetype=kotlin
au BufRead,BufNewFile *.jet set filetype=kotlin
au Syntax kotlin source ~/.vim/syntax/kotlin.vim

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_auto_trigger = 1
