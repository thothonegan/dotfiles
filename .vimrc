" GLSL syntax highlighting
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl,*.frag.glsl setf glsl 

" Turn on syntax highlighting
syntax on

" Always show the ruler
set ruler

" Enable autoindenting - remembers indentation when goes to the next line
set autoindent

" Default color theme
let g:molokai_original=1
color molokai 

" Indentation - Tabs, 4 spaces
set tabstop=4

" Enable mouse control for all modes
set mouse=a

" Folding : syntax based, 3 column foldbar, start at 20 so all are open
set foldmethod=syntax
set foldcolumn=3
set foldlevelstart=20
