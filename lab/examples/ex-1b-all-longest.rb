all_longest = []
File.open('./ex-1.txt', 'r').each do |line|
  line.strip!
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
