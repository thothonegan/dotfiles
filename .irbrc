#
## .irbrc
## IRB configuration
##
## Based partially on https://github.com/iain/osx_settings/blob/master/.irbrc
#

require 'rubygems'
require 'yaml'

# Quick exit with q
alias q exit

# Simple color codes
VT100COLOR = {}
VT100COLOR[:reset]     = "\e[0m"
VT100COLOR[:bold]      = "\e[1m"
VT100COLOR[:underline] = "\e[4m"
VT100COLOR[:gray]      = "\e[0;90m"
VT100COLOR[:red]       = "\e[31m"
VT100COLOR[:green]     = "\e[32m"
VT100COLOR[:yellow]    = "\e[33m"
VT100COLOR[:blue]      = "\e[34m"
VT100COLOR[:magenta]   = "\e[35m"
VT100COLOR[:cyan]      = "\e[36m"
VT100COLOR[:white]     = "\e[37m"

# Simple IRB prompt
IRB.conf[:PROMPT][:SOMPLE_COLOR] =
{
	:PROMPT_I => "#{VT100COLOR[:blue]}>>#{VT100COLOR[:reset]} ",
	:PROMPT_N => "#{VT100COLOR[:blue]}>>#{VT100COLOR[:reset]} ",
	:PROMPT_C => "#{VT100COLOR[:red]}?>#{VT100COLOR[:reset]} ",
	:PROMPT_S => "#{VT100COLOR[:yellow]}?>#{VT100COLOR[:reset]} ",
	:RETURN   => "#{VT100COLOR[:green]}=>#{VT100COLOR[:reset]} %s\n",
	:AUTO_INDENT => true
}

IRB.conf[:PROMPT_MODE] = :SIMPLE

# Function to load extensions safely. If you dont have pieces, it ignores.
def extend_console(name, care = true, required = true)
	if care
		require name if required
		yield if block_given?
		$console_extensions << "#{VT100COLOR[:green]}#{name}#{VT100COLOR[:reset]}"
	else
		$console_extensions << "#{VT100COLOR[:gray]}#{name}#{VT100COLOR[:reset]}"
	end

rescue LoadError
		$console_extensions << "#{VT100COLOR[:red]}#{name}#{VT100COLOR[:reset]}"
end
		
$console_extensions = []

# === Wirble - Handles coloring output and history ===
extend_console 'wirble' do
	Wirble.init
	Wirble.colorize
end
# === Wirb - Handles coloring of results (introspection) ===
extend_console 'wirb' do
	Wirb.start
end

# === Hirb - Tables for IRB ===
extend_console 'hirb' do
	Hirb.enable
	extend Hirb::Console
end

# === Awesome print - better than pretty print ===
extend_console 'ap' do
	# alias pp ap
end

# Show results of load
puts "#{VT100COLOR[:white]}~> Console extensions:#{VT100COLOR[:reset]} #{$console_extensions.join(' ')}#{VT100COLOR[:reset]}"

