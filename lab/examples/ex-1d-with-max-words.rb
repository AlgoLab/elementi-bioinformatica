longest = []
File.open('./ex-1.txt', 'r').each do |line|
  line.strip!
  # Replace ' with spaces
  line.gsub! "'", " "
  if line.split.size > longest.size
    longest = line.split
  end
end

puts "A line with the maximum number of words has #{longest.size} words and is: '#{longest.join(' ')}'"

