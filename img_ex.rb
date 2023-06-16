#encoding: utf-8

require 'rubygems'
require 'fileutils'
require 'open-uri'
require 'pdf-reader'
require_relative 'C:\Users\adano\Dropbox\work\tools\stdtools.rb'

workfile = dir_the_folder

puts "Работаем с #{workfile}"

  puts "Укажите номер страницы:"
pagenum = gets.chomp.to_i

reader = PDF::Reader.new(workfile)

reader.pages.each_with_index do |page, index|
counter = 0
 
  if index == pagenum
    media = page.xobjects
	
	media.each do |obj|
	  obj.each do |elem|
	    
		if elem.class == PDF::Reader::Stream
		  
		  f = File.open("#{index}_#{counter}.jpg", 'wb') {|f| f << elem.data}
		  counter = counter + 1
		end
	  
	  end
	end
  end

end
