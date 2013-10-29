###
#
# Solution of lab assignment 1f (http://git.io/elem-bioinf-lab1#21)
# Course: "Elementi di Bioinformatica" (http://algolab.eu/didattica/elementi-di-bioinformatica/)
# Corso di Laurea in Informatica (BSc in Computer Science)
# Univ. degli Studi di Milano-Bicocca, Milan, Italy
# Academic year: 2013/14
#
# Copyright 2013 Yuri Pirola (http://algolab.eu/pirola)
#
# This work is licensed under the Creative Commons Attribution 3.0
# Unported License. To view a copy of this license, visit
# http://creativecommons.org/licenses/by/3.0/
#
###


frequencies = {}
File.open('./ex-1.txt', 'r').each do |line|
  # Remove endlines
  line.chomp!
  # Replace ' with spaces
  line.gsub! "'", " "
  # Remove punctuation
  line.delete! '!.,;'

  line.split.each do |word|
    if not frequencies[word]
      frequencies[word] = 0
    end
    ## Alternative version:
    # frequencies[word] = 0 unless frequencies[word]
    ## The "if" could be completely avoided if frequencies had been initialized as
    # frequencies = Hash.new(0)   # return 0 if the key is not in the hash
    frequencies[word] += 1
  end
end

most_freq_word = frequencies.max_by { |x| x[1] }

puts "One of the most frequent words appears #{most_freq_word[1]} times and is: '#{most_freq_word[0]}'"
