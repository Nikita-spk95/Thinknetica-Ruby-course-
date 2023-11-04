puts "Задайте необходимую дату в формате день/месяц/год. Для начала введите число:"
day = gets.chomp.to_i
puts "введите месяц:"
month = gets.chomp.to_i
puts "введите год:"
year = gets.chomp.to_i

february_days_count = if (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0))
                        29
                      else
                        28
                      end
month_array = [31, february_days_count, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

your_day = day

(0...month - 1).each do |m|
  your_day += month_array[m]
end

puts "Порядковый номер вашей даты #{day}.#{month}.#{year} в году: #{your_day}"