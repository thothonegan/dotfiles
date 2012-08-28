#!/usr/bin/env ruby

def replaceFile(file, finalFileName, forceCopy)
	system %Q{rm -rf "#{finalFileName}"}
	linkFile(file, finalFileName, forceCopy)
end

def linkFile(file, finalFileName, forceCopy)
	if forceCopy
		system %Q{cp -R "#{Dir.pwd}/#{file}" "#{finalFileName}"}
	else
		system %Q{ln -s "#{Dir.pwd}/#{file}" "#{finalFileName}"}
	end
end

puts ">> Installing all for #{`hostname`}"

replaceAll = false

Dir[".??*", "*"].each do |file|
	if %w[. .. .git .gitignore .gitmodules Install.rb README.rdoc].include? file
		puts "-- Ignoring #{file} (ignorelist)"
		next
	end

	forceCopy = false

	finalFileName = File.join(ENV['HOME'], "#{file}")

	if RUBY_PLATFORM.downcase.include?('haiku') and %w[.vim].include? file
		finalFileName = File.join(ENV['HOME'], 'config', 'settings', 'vim', 'vimfiles')
	end

	if RUBY_PLATFORM.downcase.include?('haiku') and %w[.vimrc].include? file
		finalFileName = File.join(ENV['HOME'], 'config', 'settings', 'vim', 'vimrc')
	end

	if RUBY_PLATFORM.downcase.include?('mingw32') and %w[.vim].include? file
		finalFileName = File.join(ENV['HOME'], 'vimfiles')
		forceCopy = true
	end

	if RUBY_PLATFORM.downcase.include?('mingw32') and %w['.vimrc'].include? file
		finalFileName = File.join(ENV['HOME'], '_vimrc')
	end

	if File.exist?(finalFileName)
		if File.identical? file, finalFileName
			puts "-- Ignoring #{file} (identical)"
		elsif replaceAll
			puts ">> Replacing #{file}"
			replaceFile(file, finalFileName, forceCopy)
		else
			puts ">> Overwrite #{finalFileName}? [yanq] "
			case $stdin.gets.chomp
			when 'a'
				replaceAll = true
				replaceFile(file, finalFileName, forceCopy)
			when 'y'
				replaceFile(file, finalFileName, forceCopy)
			when 'q'
				exit
			else
				puts "!! Skipping #{file}"
			end
		end
	else
		puts ">> Linking #{file}"
		linkFile(file, finalFileName, forceCopy)
	end
end

