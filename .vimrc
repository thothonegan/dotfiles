" Disable vi compatibility
set nocompatible

" GLSL syntax highlighting
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.frag.glsl setf glsl 

" mm is Objc - not nroff
au BufNewFile,BufRead *.mm setf objcpp
" Turn on syntax highlighting
syntax on

" Always show the ruler
set ruler

" Enable autoindenting - remembers indentation when goes to the next line
set autoindent

" Default color theme
let g:molokai_original=1
color molokai 

" Set default terminal background, so we transparent properly
hi Normal ctermbg=NONE

" Indentation - Tabs, 4 spaces
set tabstop=4

" Enable mouse control for all modes
set mouse=a

" Folding : syntax based, 3 column foldbar, start at 20 so all are open
set foldmethod=syntax
set foldcolumn=3
set foldlevelstart=20

" Dont highlight the current line
set nocul

" Setup pathogen, the vim bundle system
" See https://github.com/tpope/vim-pathogen
call pathogen#infect('pathogen')

" Always show the statusline
set laststatus=2

" Show unicode
set encoding=utf-8

" Show tabs with the greater-sign
set list listchars=tab:>\ 

" Enable backspace. While most terminals does this fine anyways, gvim on windows has issues
set backspace=indent,eol,start
