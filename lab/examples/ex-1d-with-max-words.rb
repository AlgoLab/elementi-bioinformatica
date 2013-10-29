###
#
# Solution of lab assignment 1d (http://git.io/elem-bioinf-lab1#19)
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


longest = []
File.open('./ex-1.txt', 'r').each do |line|
  # Remove endlines
  line.chomp!
  # Replace ' with spaces
  line.gsub! "'", " "

  if line.split.size > longest.size
    longest = line.split
  end
end

puts "A line with the maximum number of words has #{longest.size} words and is: '#{longest.join(' ')}'"
