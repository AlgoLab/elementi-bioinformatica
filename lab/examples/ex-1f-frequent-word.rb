frequencies = {}
File.open('./ex-1.txt', 'r').each do |line|
  line.strip!
  # Replace ' with spaces
  line.gsub! "'", " "
  # Remove punctuation
  '!.,'.each_char do |mark|
    line.gsub! mark, ''
  end

  line.split.each do |word|
    if not frequencies[word]
      frequencies[word] = 0
    end
    ## Alternative version:
    # frequencies[word] = 0 unless frequencies[word]
    ## The if could be avoided if frequencies had been initialized as
    # frequencies = Hash.new(0)   # return 0 if the key is not in the hash
    frequencies[word] += 1
  end
end

most_freq_word = frequencies.max { |x,y| x[1] <=> y[1] }

puts "One of the most frequent words appears #{most_freq_word[1]} times and is: '#{most_freq_word[0]}'"

