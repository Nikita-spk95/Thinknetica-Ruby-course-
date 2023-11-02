puts "Задайте необходимую дату в формате день/месяц/год. Для начала введите число:"
day = gets.chomp.to_i
puts "введите месяц:"
month = gets.chomp.to_i
puts "введите год:"
year = gets.chomp.to_i

month_array = [31, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  if (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))
    month_array.insert(2, 29)
    puts "Год високосный (366 дней)"
  else 
    month_array.insert(2, 28)
    puts "Год не високосный год (365 дней)"
  end

your_day = day

# в данном случае я добавляю в условие -1 для поправки на индексацию при вводе пользователем месяца
(0...month - 1).each do |i|
  your_day += month_array[i]
end

puts "Порядковый номер вашей даты #{day}.#{month}.#{year} в году: #{your_day}"