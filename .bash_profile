#
# .bash_profile
# Bash settings
#
# OLD : zsh is replacement
#

# If not interactive, don't do anything
[ -z "$PS1" ] && return

# ---- FUNCTIONS ----

#
# Determine if we are running on OSX or not
#
function isMacOSX()
{
	if [ `uname -s` = "Darwin" ]; then
		echo "YES";
		return;
	else
		echo "NO";
		return;
	fi
}

#
# Determine if we are running on Linux or not
#
function isLinux()
{
	if [ `uname -s` = "Linux" ]; then
		echo "YES";
		return;
	else
		echo "NO";
		return;
	fi
}

# ---- MAIN PROGRAM ----

# History control (Bash)
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups # Don't put duplicates in the history
shopt -s histappend # Append history
shopt -s checkwinsize # Update window size (LINES and COLUMNS) after every command

# Bash completion (if available)
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi

if [ -d /opt/local/etc/bash_completion.d/ ]; then # MacPorts
	. /opt/local/etc/bash_completion.d/*
fi

if [ -d $HOME/Local/bash-completion/ ]; then # Local
	. $HOME/Local/bash-completion/*
fi

# Fancy prompt
if [[ `hostname -s` == "Griffin" ]] || [[ `hostname -s` == "r08klpwdf" ]] || [[ `hostname -s` == "r02klpwdf" ]] ; then
	export hostColor="01;36m";
elif [[ `hostname -s` == "dragon" ]]; then
	export hostColor="01;32m";
elif [[ `hostname -s` == "Gargoyle" ]]; then
	export hostColor="01;34m";
else
	export hostColor="01;32m";
fi

export PS1='${debian_chroot:+($debian_chroot)}\[\033[${hostColor}\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]';

if type __git_ps1 > /dev/null 2>&1; then
	# Add git ps1
	export PS1="$PS1\[\033[01;35m\]\$(__git_ps1)\[\033[00m\]"
fi

# Add end
export PS1="$PS1 \$ "

# If we're an xterm, set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*)
	;;
esac

# Enable colors for everything in existance
export CLICOLOR=1
export LSCOLORS=DxFxCxGxBxegedabagacad
export LS_COLORS='no=00:fi=00:di=01;36:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.flac=01;35:*.mp3=01;35:*.mpc=01;35:*.ogg=01;35:*.wav=01;35:';

alias grep='grep --color'

# Magic directories
export HACKERGUILD="$HOME/Repositories/IDC/hackerguild"
alias hackerguild='cd ~/Repositories/IDC/hackerguild'
alias idc='cd ~/Repositories/IDC'
alias idesignco='cd ~/Repositories/IDesignCO/'
alias aether='cd ~/Repositories/DevHat/aether/'
alias hackerguild-git='cd ~/Repositories/hackerguild'
alias idesignco-git='cd ~/Repositories/IDesignCO-git/'
alias vcc3d='cd ~/Repositories/vcc3d/'

# Aliases for commands
alias l='ls -CF'
alias ll='ls -l'
alias la='ls -A'
alias vman="MANPAGER=\"col -b | view -c 'set ft=man nomod nolist' -\" man"

# Our editor
export EDITOR=vim

# Mac specific
if [[ `isMacOSX` = "YES" ]] ; then
	# Add macports to path
	export PATH=/opt/local/bin:/opt/local/sbin:$PATH

	# Ada
	export PATH=$PATH:/opt/gnat-gpl-2010/bin

	# KDE paths
	export PATH=$HOME/Library/Preferences/KDE/bin:$PATH
	export KDEDIRS=$HOME/Library/Preferences/KDE

	# Doxygen path
	export PATH=$HOME/Applications/Doxygen.app/Contents/Resources:$PATH

	# Apps
	alias macvim='open -a MacVIM'
	alias 0xed='open -a 0xED'
	alias autorun='open -a "Automator Runner"'

	# Allow attaching to GL programs (GLDebugger)
	export GL_ENABLE_DEBUG_ATTACH=YES

	# Gems
	export PATH=/Users/thothonegan/.gem/ruby/1.8/bin:$PATH

	# Put brew first
	export PATH=/usr/local/bin:$PATH

elif [[ `isLinux` = "YES" ]]; then
	# KDE paths
	export PATH=$HOME/.kde/bin:$PATH

	# Alias open to something sane. We dont care about openvt.
	alias open='kde-open'

fi

# Add LLDB and friends to the end if we're on OSX
if [[ `isMacOSX` = "YES" ]]; then
	export PATH=$PATH:/Developer/usr/bin
	export PATH=$PATH:$HOME/local/android-sdk-mac_x86/platform-tools/
	export PATH=$PATH:$HOME/local/android-ndk-r5c/toolchains/arm-linux-androideabi-4.4.3/prebuilt/darwin-x86/bin
fi

# Distcc machines
export DISTCC_POTENTIAL_HOSTS='localhost Polaris.local Gargoyle.local Michael-Orlandos-MacPro.local Chases-Mac-Pro.local'

