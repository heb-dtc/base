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
set tabstop=4
set shiftwidth=4
set expandtab

" Search config
set ignorecase
set smartcase
set incsearch
set hlsearch  

" Beep
set visualbell
set noerrorbells

syntax enable
set background=dark
colorscheme solarized
set t_Co=16
filetype plugin indent on

set backspace=indent,eol,start

set nocscopeverbose 
let mapleader="," 
nmap <silent> <Leader>of :FSHere<CR> 
nmap <silent> <Leader>or :FSSplitRight<CR> 

" ctrl-n to toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

"let g:ctrlp_map = ’<leader>c’
" Default parameters for ack
"let g:ackprg="ack -H --nocolor --nogroup --column" 
" Put a marker and search
"nmap <leader>j mA:Ack<space>
" Put a marker and search current word under cursor
"nmap <leader>j amA:Ack "<C-r>=expand("<cword>")<cr>"
"nmap <leader>j amA:Ack "<C-r>=expand("<cWORD>")<cr>"

" new split appears below or right (feels more natural)
set splitbelow
set splitright

" gitgutter settings
hi clear signColumn

" airline settings
" always show airline status bar
set laststatus=2
" show for tabs
let g:airline#extensions#tabline#enabled = 1
" use patched font
let g:airline_powerline_fonts = 1
