basket_hash = {}

loop do
  puts "Введите название товара, что бы закончить введите 'стоп'."
  product_name = gets.chomp.downcase

  break if product_name == "стоп"

  puts "Введите стоимость вашего товара: "
  price = gets.chomp.to_f

  puts "Введите количество единиц вашего товара: "
  quantity = gets.chomp.to_i
  
  basket_hash[product_name.to_sym] = {price: price, quantity: quantity}   
end

full_price = 0
basket_hash.each do |key, value|
  puts "Товар: #{key}\nЦена за ед.: #{value[:price]}\nКол-во ед. товара: #{value[:quantity]}"
  puts "Финальная цена на товар #{key}: #{value[:price] * value[:quantity]}"
end