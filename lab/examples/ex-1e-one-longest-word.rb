longest = ''
File.open('./ex-1.txt', 'r').each do |line|
  line.strip!
  # Replace ' with spaces
  line.gsub! "'", " "
  # Remove punctuation
  '!.,'.each_char do |mark|
    line.gsub! mark, ''
  end
  line.split.each do |word|
    if word.length > longest.length
      longest = word
    end
  end
end

puts "One of the longest words has #{longest.length} letters and is: '#{longest}'"

