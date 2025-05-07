require 'csv'
require 'fileutils'

n = Dir.entries(".").select {|f| !File.directory? f}

puts "Наберите четырёхзначный номер из имени файла. Подсказка:"

n.map{|m| puts m if m[-1].chomp == "v"}
num = gets.chomp.to_s

csv = CSV.read("out_#{num}.csv", col_sep: ",", quote_char: '"')

final = CSV.open("#{num}.csv", "wb", col_sep: ";")

csv.each do |work|

final << work

end

