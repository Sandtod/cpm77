# encoding: utf-8

public

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
