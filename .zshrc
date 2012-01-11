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
plugins=()

source $ZSH/oh-my-zsh.sh

# Adjust prompt slightly (add hostname)

# Based off default prompt from muse.zsh-theme
PROMPT='%{$PROMPT_SUCCESS_COLOR%}%m %~%{$reset_color%} %{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}%{$PROMPT_PROMPT%}ᐅ%{$reset_color%} '

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

#export PATH=/usr/local/bin:/Users/thothonegan/.gem/ruby/1.8/bin:/Users/thothonegan/Applications/Doxygen.app/Contents/Resources:/Users/thothonegan/Library/Preferences/KDE/bin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/gnat-gpl-2010/bin:/Developer/usr/bin:/Users/thothonegan/local/android-sdk-mac_x86/platform-tools/:/Users/thothonegan/local/android-ndk-r5c/toolchains/arm-linux-androideabi-4.4.3/prebuilt/darwin-x86/bin

# === Alias functions ===

hackerguild() { cd $HOME/Repositories/IDC/hackerguild }

# === Platform specific ===

# Remove the version from the os
os=${OSTYPE//[0-9.]/}

# OSX
if [[ "$os" == "darwin" ]]; then
	# Allow attaching to GL programs (GLDebugger)
	export GL_ENABLE_DEBUG_ATTACH=YES

	# Apps
	macvim() { open -a MacVIM $@ }
	0xed() { open -a 0xED $@ }
fi

# Linux
if [[ "$os" == "linux-gnu" ]]; then
	# Make 'open' act like OSX : run kde-open
	open() { kde-open $@ }
fi

# === Ruby/Rails ===

# Load RVM if available
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

