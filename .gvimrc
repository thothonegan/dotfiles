" ==== MacVIM Transparent background ====

set go-=T
set bg=dark

if &background == "dark"
	hi normal guibg=black
	" usually 8
	if has("gui_macvim")
		set transp=20
	endif
else
	hi normal guibg=white

	if has("gui_macvim")
		set transp=8
	endif
endif
