#!/usr/bin/env ruby

def replaceFile(file)
	system %Q{rm -rf "$HOME/#{file}"}
	linkFile(file)
end

def linkFile(file)
	system %Q{ln -s "$PWD/#{file}" "$HOME/#{file}"}
end

puts ">> Installing all for #{`hostname`}"

replaceAll = false

Dir[".??*", "*"].each do |file|
	if %w[. .. .git .gitignore .gitmodules Install.rb README.rdoc].include? file
		puts "-- Ignoring #{file} (ignorelist)"
		next
	end

	finalFileName = File.join(ENV['HOME'], "#{file}")

	if File.exist?(finalFileName)
		if File.identical? file, finalFileName
			puts "-- Ignoring #{file} (identical)"
		elsif replaceAll
			puts ">> Replacing #{file}"
			replaceFile(file)
		else
			puts ">> Overwrite #{finalFileName}? [yanq] "
			case $stdin.gets.chomp
			when 'a'
				replaceAll = true
				replaceFile (file)
			when 'y'
				replaceFile (file)
			when 'q'
				exit
			else
				puts "!! Skipping #{file}"
			end
		end
	else
		puts ">> Linking #{file}"
		linkFile(file)
	end
end

