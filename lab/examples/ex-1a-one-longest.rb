longest = ""
File.open('./ex-1.txt', 'r').each do |line|
  line.strip!
  if line.length > longest.length
    longest = line
  end
end

puts "The longest line has #{longest.length} characters and is: '#{longest}'"

