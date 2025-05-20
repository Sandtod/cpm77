# Нарезка результатов из lab.olympiada.ru, version 2.0
#encoding: utf-8

require_relative 'stdtools.rb'
require 'csv'
require 'date'
require 'fileutils'

PATH = "/mnt/c/Users/adano/OneDrive/CPM/lab"
HEADERS = ['reg_user_id','last_name','first_name','patronymic','key_grade','key','score','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25']
RU_HEADERS = ['ID','Фамилия','Имя','Отчество','Класс','Ключ','Результат','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25'].join(";")
row_hash = Hash.new { |h, k| h[k] = [] } # массив строк для каждого логина
hash_counter = 0

puts "Введите четырёхзначный номер работы. Подсказка:"

show_folders(PATH) # показываем имеющиеся папки (см. stdtools.rb)

name = gets.chomp.to_s
folder = File.join(PATH, name)
sourcepath = File.join(folder, "out_#{name}.csv")
results = File.join(folder, "results")
FileUtils.mkdir_p(results)

CSV.foreach(sourcepath, headers: true) do |row|

  login = row.to_s.match(/sch\d{6}/).to_s

    row_data = HEADERS.map { |h| row[h] }.join(";")
    row_hash[login] << "#{row_data}\n"
	
end

row_hash.each do |key, value|

  filename = create_file(results, key, RU_HEADERS) # stdtools.rb
  
  File.open(filename, 'a') do |f|
    
	f.write value.join("").encode('windows-1251', invalid: :replace, undef: :replace, replace: '?')
	
  end

end