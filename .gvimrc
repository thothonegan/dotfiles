" ==== MacVIM Transparent background ====

set go-=T
set bg=dark

if &background == "dark"
	hi normal guibg=black
	" usually 8
	set transp=20
else
	hi normal guibg=white
	set transp=8
endif
