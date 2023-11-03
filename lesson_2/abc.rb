numerized_alphabet = {}
vowels = ['а', 'е', 'ё', 'и', 'о', 'у', 'ы', 'э', 'ю', 'я'] 
alphabet = ('а'..'я').to_a
alphabet.insert(6, 'ё')
alphabet.each_with_index do |key, value|
  if vowels.include?(key)
    numerized_alphabet[key] = value + 1
  end
end
puts numerized_alphabet.to_s
