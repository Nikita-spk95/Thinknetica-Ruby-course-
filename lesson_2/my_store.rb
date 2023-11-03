basket_hash = {}

loop do
  puts "Введите название товара, что бы закончить введите 'стоп'."
  product_name = gets.chomp.downcase

  break if product_name == "стоп"

  puts "Введите стоимость вашего товара: "
  price = gets.chomp.to_f

  puts "Введите количество единиц вашего товара: "
  quantity = gets.chomp.to_i
  
  basket_hash[product_name.to_sym] = {price => quantity}    
end

full_price = 0
basket_hash.each do |key, value|
  value.each do |price_value, quantity_value|
    full_price += price_value * quantity_value
  end
end

puts "Список товаров в вашей карзине: #{basket_hash}"

puts "Итоговая сумма за все покупки: #{full_price}"