numbers_array = []

first_number = 10

loop do 
  first_number += 5
  break if first_number > 100
  numbers_array << first_number
end

puts numbers_array.to_s