#
# .zshrc
# ZSH configuration
#

# ======= OH-MY-ZSH setup ======

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# Linux console doesnt have the font support required for muse
if [[ $TERM == "linux" ]]; then
	ZSH_THEME="robbyrussell"
else
	ZSH_THEME="muse"
fi

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(nyan)

if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
	plugins+=(terminalapp)
fi

source $ZSH/oh-my-zsh.sh

# Adjust prompt slightly (add hostname)
# We color it differently based on hostname
host=`hostname -s`
if [[ $host == "Griffin" ]]; then
	PROMPT_HOSTNAME="%{$FG[220]%}%m%{$reset_color%}"
elif [[ $host == "dragon" ]]; then
	PROMPT_HOSTNAME="%{$FG[082]%}%m%{$reset_color%}"
else
	PROMPT_HOSTNAME="%{$FG[160]%}%m%{$reset_color%}"
fi

# Based off default prompt from muse.zsh-theme
PROMPT='$PROMPT_HOSTNAME %{$PROMPT_SUCCESS_COLOR%}%~%{$reset_color%} %{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}%{$PROMPT_PROMPT%}ᐅ%{$reset_color%} '

# === Autocomplete after equals automatically ===

setopt magic_equal_subst

# === Command-Not-Found when available ===

if [[ -f /etc/zsh_command_not_found ]]; then
	. /etc/zsh_command_not_found
fi

# === Keychain when available - manages SSH keys ===

if [[ -f `which keychain` ]]; then
	if [[ -f ~/.ssh/id_dsa ]]; then
		keychain -q ~/.ssh/id_dsa
	fi

	if [[ -f ~/.ssh/id_rsa ]]; then
		keychain -q ~/.ssh/id_rsa
	fi

	# Ok, now that we're done, source the keys it created
	if [[ -f ~/.keychain/${HOST}-sh ]]; then
		. ~/.keychain/${HOST}-sh
	fi

	if [[ -f ~/.keychain/${HOST}-sh-gpg ]]; then
		. ~/.keychain/${HOST}-sh-gpg
	fi
fi

# === PSL1GHT ===

export PS3DEV=$HOME/Local/ps3dev/
export PSL1GHT=$PS3DEV/psl1ght

# === Path ===

# Standard local paths
export PATH=/usr/local/sbin:/usr/local/bin:/opt/local/sbin:/opt/local/bin

# Standard paths
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin

# X11 apps
export PATH=$PATH:/usr/X11/bin

# PSL1GHT
export PATH=$PATH:$PS3DEV/bin:$PS3DEV/ppu/bin:$PS3DEV/spu/bin:$PSL1GHT/bin

# G15Message
export PATH=$PATH:$HOME/Local/g15message/bin

#export PATH=/usr/local/bin:/Users/thothonegan/.gem/ruby/1.8/bin:/Users/thothonegan/Applications/Doxygen.app/Contents/Resources:/Users/thothonegan/Library/Preferences/KDE/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/gnat-gpl-2010/bin:/Developer/usr/bin:/Users/thothonegan/local/android-sdk-mac_x86/platform-tools/:/Users/thothonegan/local/android-ndk-r5c/toolchains/arm-linux-androideabi-4.4.3/prebuilt/darwin-x86/bin

# === Alias functions ===

export HACKERGUILD=$HOME/Repositories/IDC/hackerguild

hackerguild() { cd $HACKERGUILD }

# === Platform specific ===

# Remove the version from the os
os=${OSTYPE//[0-9.]/}

# OSX
if [[ "$os" == "darwin" ]]; then
	# Allow attaching to GL programs (GLDebugger)
	export GL_ENABLE_DEBUG_ATTACH=YES

	# Use gls if available - gnu's colors are quite a bit better
	if [[ -f /usr/local/bin/gls ]]; then
#		eval $(gdircolors -b)
#		alias ls="gls --color=auto";
	fi

	# Apps
	macvim() { open -a MacVIM $@ }
	0xed() { open -a 0xED $@ }

	# Notification using growl
	notification() { echo -e $'\e]9;'${1}'\007' ; return ; }

	# Add macro for easy access to ags
	ags() { cd ~/Website/rails/ags/ }
fi

# Linux
if [[ "$os" == "linux-gnu" ]]; then
	# Make 'open' act like OSX : run kde-open
	open() { kde-open $@ }

	# For some reason the manpager doesnt work on linux. Set it to default.
	unset MANPAGER

	# Add support for notification
	notification()
	{
		message=${1}
		title=${2}

		if [[ ${2} == "" ]]; then
			title="Notification";
		fi

		kdialog --passivepopup "${message}" 5 --title "${title}"

		if [[ -f `which g15message` ]]; then
			g15message -t "${title}" "${message}"
		fi
	}
fi

# === Ruby/Rails ===

# Load RVM if available
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"


# === Blackberry SDK ===

#[[ -s "$HOME/Local/bbndk-1.0/bbndk-env.sh" ]] && . "$HOME/Local/bbndk-1.0/bbndk-env.sh"

