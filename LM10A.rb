####################   LOGIMAT 1.7 ALPHA        EQUATION CALCULATOR ####################

#   BUGS:
#
#   - NO CURRENTLY KNOWN
#
#   REMEMBER:
#
#   - REMOVE DB's if you want to run the program without debugging
#
#   TODO:
#
#   - Optimize code
#   - Make parantheses a thing
#   - Let the user select variable name
#   - Add VC output check
#   - Add restrictions to not allow typing in invalid inputs in getInputVC and getInputandCalculateDC


# Variables

$ver = "1.7 ALPHA"
$fr = true

# Functions

def putIntro
  if $fr == true
    puts
    puts "Welcome to LOGIMAT #{$ver}!"
    puts
    sleep(3)
    puts "Please state which function you would like to use by typing the letter in front of the corresponding function:"  
    $fr = false
  else
    puts
    puts "Would you like to perform another calculation. Type Y if yes, or N if no:"
    puts
    sel = gets.chomp.downcase
    puts
    until sel == "y" or sel == "n"
      puts "You have typed an invalid letter. Try again!"
      puts
      sel = gets.chomp.downcase
      puts
    end
    if sel == "y"
      puts "Please state which function you would like to use by typing the letter in front of the corresponding function:"
    else
      puts "Ok, bye bye!"
      sleep (2)
      exit
    end
  end
  puts
  puts "(D) Difference calculator"
  puts "(V) Variable calculator"
  puts "(E) Exit"
  puts
  sel = gets.chomp.downcase
  puts
  until sel == "d" or sel == "v" or sel == "e"
    puts "You have typed an invalid letter. Try again!"
    puts
    sel = gets.chomp.downcase
    puts
  end
  if sel == "d"
    puts "Starting DC (Difference Calculator)..."
    sleep(1)
    getInputandCalculateDC
  elsif sel == "v"
    puts "Starting VC (Variable Calculator)..."
    sleep(1)
    getInputVC
  elsif sel == "e"
    puts "Bye bye!"
    sleep (2)
    puts
  end
end

def getInputandCalculateDC
  puts
  puts "Please enter the left row:"
  vld = gets.chomp
  vld = eval(vld)
  puts "The left row specified is: #{vld}."
  puts
  puts "Please enter the right row:"
  hld = gets.chomp
  hld = eval(hld)
  puts "The right row specified is: #{hld}."
  puts
  putOutputDC(vld, hld)
end

def getInputVC
  puts
  puts "NOTE: AS THIS IS A PREVIEW, DON'T USE ANY OTHER VARIABLE NAME THAN X, AND DON'T USE PARANTHESES. THESE FUNCTIONS DO NOT WORK YET!!"
  puts "Please enter the left row:"
  vlv = gets.chomp.downcase
  puts "The left row specified is: #{vlv}."
  puts
  puts "Please enter the right row:"
  hlv = gets.chomp.downcase
  puts "The right row specified is: #{hlv}."
  puts
  calculateVC(vlv, hlv)
end

def calculateVC(vlv, hlv)
  vlvn = 0
  vlvx = 0
  hlvn = 0
  hlvx = 0
  tn = 0
  vlv = vlv.gsub(" ", "")
  vlv = vlv.gsub("*-", "*_")
  vlv = vlv.gsub("/", "~")
  vlv = vlv.gsub(",",".")
  hlv = hlv.gsub(" ", "")
  hlv = hlv.gsub("*-", "*_")
  hlv = hlv.gsub("/", "~")
  hlv = hlv.gsub(",", ".")
    
  separation = vlv.split(/(?=[+-])/)

  separation.each do |line|
    line = line.gsub("_", "-")
    if line.index("x") == nil
      f = true
      separation = line.split(/(?=[*~])/)
      
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
      vlvn += tn
    elsif line.index("*") == nil and line.index("~") == nil
      if line.index("x") == 0
        vlvx += 1
      else
        np = line.index("x") - 1
        if line[np] =~ /[[:digit:]]/
          line = line.gsub("x", "")
          vlvx += line.to_f
        elsif line[np] == "-"
          vlvx -= 1
        else
          vlvx += 1
        end
      end
    else
      f = true
      while line.index("x") != nil
        if line.index("x") == 0
          line = line.sub("x", "1")
        else
          np = line.index("x") - 1
          if line[np] =~ /[[:digit:]]/
            line = line.sub("x", "")
          else
            line = line.sub("x", "1")
          end
        end
      end
      separation = line.split(/(?=[*~])/)
      
      separation.each do |line3|
        if f == true
          tn = line3.to_f
          f = false
        elsif line3[0] == "*"
          line3 = line3.sub("*", "")
          tn = tn*line3.to_f
        else
          line3 = line3.sub("~", "")
          tn = tn/line3.to_f
        end
      end
      vlvx += tn
    end
  end

  separation = hlv.split(/(?=[+-])/)
  
  separation.each do |line|
    line = line.gsub("_", "-")
    if line.index("x") == nil
      f = true
      separation = line.split(/(?=[*~])/)
      
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
      hlvn += tn
    elsif line.index("*") == nil and line.index("~") == nil
      if line.index("x") == 0
        hlvx +=1
      else
        np = line.index("x") - 1
        if line[np] =~ /[[:digit:]]/
          line = line.gsub("x", "")
          hlvx += line.to_f
        elsif line[np] == "-"
          hlvx -=1
        else
          hlvx += 1
        end
      end
    else
      f = true
      while line.index("x") != nil
        if line.index("x") == 0
          line = line.sub("x", "1")
        else
          np = line.index("x") - 1
          if line[np] =~ /[[:digit:]]/
            line = line.sub("x", "")
          else
            line = line.sub("x", "1")
          end
        end
      end
      separation = line.split(/(?=[*~])/)
      
      separation.each do |line3|
        if f == true
          tn = line3.to_f
          f = false
        elsif line3[0] == "*"
          line3 = line3.sub("*", "")
          tn = tn*line3.to_f
        else
          line3 = line3.sub("~", "")
          tn = tn/line3.to_f
        end
      end
      hlvx += tn
    end
  end
  vlv = vlvx + hlvx*(-1)
  hlv = hlvn + vlvn*(-1)
  hlv = hlv/vlv
  
  putOutputVC(hlv)
end

def putOutputDC(vld, hld)
  puts "Calculating..."
  sleep(1)
  if vld > hld
    puts "The left row is greater than the right row"
  elsif vld == hld
    puts "The left row is equal to the right row"
  else
    puts "The right row is greater than the left row"
  end
  puts
  putIntro
end

def putOutputVC(hlv)
  puts "The variable X in the equation is equal to: #{hlv}"
  putIntro
end

# Runcode

putIntro

########################################################################################