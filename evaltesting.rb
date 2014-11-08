x = gets.chomp

if x =~ /[[:digit:]]/
  puts "numerical"
else
  puts "letter"
end

