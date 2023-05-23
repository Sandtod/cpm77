#encoding: utf-8

require 'rubygems'
require 'fileutils'
require 'open-uri'
require 'pdf-reader'

dir_list = Dir.entries(".").select {|f| !File.directory? f}
 puts "Choose the pdf file:"
dir_list.map{|m| puts m if m[-1].chomp == "f"}
filename = gets.chomp.to_s
  puts "Enter the page number:"
pagenum = gets.chomp.to_i

reader = PDF::Reader.new(filename)

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
