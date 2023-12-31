#Запрашиваем у пользователя данные о сторонах искомого треугольника 
puts "Введите значние длины стороны a"
a = gets.chomp.to_i
puts "Введите значние длины стороны b"
b = gets.chomp.to_i
puts "Введите значние длины стороны c"
c = gets.chomp.to_i

#Задаём массив и сортируем стороны в порядке возрастания
sides = [a, b, c].sort

#Задаём условия, определяем тип искомого треугольника, выдаём ответ пользователю
if a == b && b == c 
  puts "Треугольник равносторонний и равнобедренный"
elsif a == b || a == c || b == c 
  puts "Треугольник равнобедренный"
#Элементы массива подставляем в теорему Пифагора, сначала два катета 
#меньшие по значению, после гипотенуза большая по возрастанию 
elsif sides[0]**2 + sides[1]**2 == sides[2]**2
  puts "Треугольник прямоугольный"
else 
  puts "Треугольник является произвольным"
end