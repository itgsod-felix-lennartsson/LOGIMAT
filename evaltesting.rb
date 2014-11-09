x = gets.chomp

f = true
x = x.gsub("/", "~")

tn = 0

separation = x.split(/(?=[*~])/)

separation.each do |line2|
  if f == true
    tn = line2.to_f
    f = false
  elsif line2[0] == "*"
    line2 = line2.sub("*", "")
    tn = tn*line2.to_f
  else
    line2 = line2.sub("~", "")
    tn = tn/line2.to_f
  end
end

puts tn