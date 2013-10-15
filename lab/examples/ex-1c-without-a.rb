longest = ""
File.open('./ex-1.txt', 'r').each do |line|
  line.strip!
  puts line.gsub("a", "")
end


