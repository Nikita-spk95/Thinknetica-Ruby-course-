#Запрашиваю у пользователя значение основания
puts "Введите значение основания расчитываемого треугольника: "

#Объявляю переменную для основания, командой убераю лишние символы после 
#ввода, перевожу в класс целых чисел
a = gets.chomp.to_i

#Запрашиваю у пользователя значение высоты
puts "Введите значение высоты расчитываемого треугольника: "

#Объявляю переменную для высоты, командой убераю лишние символы после 
#ввода, перевожу в класс целых чисел
h = gets.chomp.to_i

#Объявляю переменную для площади, подствляю формулу
s = (a * h)/2

#Ввывожу ответ для пользователя используя интреполяцию для переменных
puts "Ответ: значение площади треугольника S = #{s}"