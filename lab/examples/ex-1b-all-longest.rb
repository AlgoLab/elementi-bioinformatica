###
#
# Solution of lab assignment 1b (http://git.io/elem-bioinf-lab1#17)
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


all_longest = []
File.open('./ex-1.txt', 'r').each do |line|
  # Remove endlines
  line.chomp!

  if all_longest.empty? || line.length > all_longest[0].length
    all_longest = [ line ]
  elsif line.length == all_longest[0].length
    all_longest << line
  end
end

unless all_longest.empty?
  puts "The longest lines are #{all_longest.size} and have #{all_longest[0].length} characters."
  puts "They are:"
  all_longest.each do |line|
    puts "'#{line}'"
  end
end
