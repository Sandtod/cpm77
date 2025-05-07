# encoding: utf-8

require 'json'

public

def any_labelling_shift(json)

shapes = json['shapes']

  shapes.each do |pointlist|

    points_arr = pointlist['points']
    points_arr.each do |obj|
 
      obj = obj.map! {|n| n + 1}   
 
    end

  end

end

def dir_the_folder # метод для выбора файла, который нужно будет обрабатывать

  puts "Скопируйте путь к рабочей папке"
work_folder = gets.chomp
  puts "Введите нужное расширение файлов"
file_extension = gets.chomp.prepend(".")

Dir.chdir(work_folder)
filelist_array = Dir.entries(".").select {|f| File.file?(f) && File.extname(f) == file_extension}
filelist_hash = {}
filelist_array.sort.each_with_index { |str, i| filelist_hash[i+1] = str }

  puts "Выберите файл для работы, указав его номер в списке"

  filelist_hash.each do |key, value|
    puts "#{key}. #{value}"
  end

filenumber = gets.chomp.to_i
workfile = filelist_hash[filenumber]

return workfile

end

# PasswordsStack - класс для генерации паролей трёх типов.

class PasswordsStack

	def generate_password_long

		[1,2,3,4,5,6,7,8,9,'q','w','r','t','i','s','d','f','g','h','j','z','v','b','m'].sample(10).map(&:to_s).join

	end

	def generate_password_short

		((1..9).to_a.sample(1) + (0..9).to_a.sample(6)).map(&:to_s).join

	end
	
	def generate_password_archive
	
		((1..9).to_a.sample(1) + (0..9).to_a.sample(7)).map(&:to_s).join
	
	end

end

# метод получения имён папок из директории, заданной в path

def show_folders(path, limit: nil, show_hidden: false)
  unless Dir.exist?(path)
    puts "Ошибка: директории '#{path}' не существует!"
    return
  end

  dirs = Dir.children(path).each_with_object([]) do |entry, arr|
    next if ['.', '..'].include?(entry)
    next if !show_hidden && entry.start_with?('.')
    
    full_path = File.join(path, entry)
    if File.directory?(full_path)
      arr << {
        name: entry,
        mtime: File.mtime(full_path)        
      }
    end
  end

  sorted = dirs.sort_by { |d| -d[:mtime].to_i }
  sorted = sorted.take(limit) if limit

  # Красивый вывод
  max_name = sorted.map { |d| d[:name].length }.max
  
  puts "-" * (25 + max_name)
  sorted.each do |dir|
    puts " #{dir[:name].ljust(max_name)} (изменена #{dir[:mtime].strftime('%Y-%m-%d %H:%M')})"
  end
  puts "-" * (25 + max_name)
  
end