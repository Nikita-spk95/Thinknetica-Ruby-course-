numerized_alphabet = {}
vowels = ["a","e","i","o","u","y"] 
alphabet = ('a'..'z')
alphabet.each_with_index do |key, value|
  if vowels.include?(key)
    numerized_alphabet[key] = value + 1
  end
end
puts numerized_alphabet.to_s
