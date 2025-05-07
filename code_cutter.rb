# Нарезка кодов из lab.olympiada.ru, version 2.0
#encoding: utf-8

require_relative 'stdtools.rb'
require 'date'
require 'fileutils'

PATH = "/mnt/c/Users/adano/OneDrive/CPM/lab"
HEADERS = "Логин;Класс;Ключ"
row_hash = Hash.new { |h, k| h[k] = [] }
hash_counter = 0

def create_file(path, login, headers)
  
  filename = File.join(path, "#{login}.csv")
  
  unless File.exist?(filename)
    File.open(filename, 'w') {|f| f.puts headers.encode("windows-1251")}
  end
  
  return filename

end

puts "Введите четырёхзначный номер работы. Подсказка:"

show_folders(PATH) # показываем имеющиеся папки (см. stdtools.rb)

name = gets.chomp.to_s
folder = File.join(PATH, name)
sourcepath = File.join(folder, "codes_#{name}.csv")
codes = File.join(folder, "codes")
FileUtils.mkdir_p(codes)

file = File.open(sourcepath)

puts "-" * 25
puts "Заполняем хэш строками:"

file.each_with_index do |row, index|

  login = row.match(/sch\d{6}/).to_s
  row_hash[login].push(row)
  
  if index % 1000 == 0 && index > 0
    puts "Обработано #{index} строк."
  end

end

total_logins = row_hash.size
puts "-" * 25
puts "Обрабатываем логины:"

row_hash.each do |key, value|  
  
  filename = create_file(codes, key, HEADERS)
  
  File.open(filename, 'a') do |f|
    f.write value.join("\n")
  end
  
  hash_counter = hash_counter + 1
  if hash_counter % 10 == 0 || hash_counter == total_logins
    percent = (hash_counter.to_f/total_logins*100).round(1)
    puts "Обработано #{hash_counter} логинов из #{total_logins} (#{percent}%)"
  end

end