#!/usr/bin/env ruby

def replaceFile(file, finalFileName)
	system %Q{rm -rf "#{finalFileName}"}
	linkFile(file)
end

def linkFile(file, finalFileName)
	system %Q{ln -s "$PWD/#{file}" "#{finalFileName}"}
end

puts ">> Installing all for #{`hostname`}"

replaceAll = false

Dir[".??*", "*"].each do |file|
	if %w[. .. .git .gitignore .gitmodules Install.rb README.rdoc].include? file
		puts "-- Ignoring #{file} (ignorelist)"
		next
	end

	finalFileName = File.join(ENV['HOME'], "#{file}")

	if RUBY_PLATFORM.downcase.include?('haiku') and %w[.vim].include? file
		finalFileName = File.join(ENV['HOME'], 'config', 'settings', 'vim', 'vimfiles')
	end

	if RUBY_PLATFORM.downcase.include?('haiku') and %w[.vimrc].include? file
		finalFileName = File.join(ENV['HOME'], 'config', 'settings', 'vim', 'vimrc')
	end

	if File.exist?(finalFileName)
		if File.identical? file, finalFileName
			puts "-- Ignoring #{file} (identical)"
		elsif replaceAll
			puts ">> Replacing #{file}"
			replaceFile(file, finalFileName)
		else
			puts ">> Overwrite #{finalFileName}? [yanq] "
			case $stdin.gets.chomp
			when 'a'
				replaceAll = true
				replaceFile(file, finalFileName)
			when 'y'
				replaceFile(file, finalFileName)
			when 'q'
				exit
			else
				puts "!! Skipping #{file}"
			end
		end
	else
		puts ">> Linking #{file}"
		linkFile(file, finalFileName)
	end
end

