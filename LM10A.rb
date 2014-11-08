####################   LOGIMAT 1.5 ALPHA        EQUATION CALCULATOR ####################

#   BUGS:
#
#   - EVAL DOES NOT CALCULATE PROPERLY (I.E 1/5 = 0 != true)
#   - SEVERAL OTHER PROBLEMS
#
#   REMEMBER:
#
#   - REMOVE DB's if you want to run the program without debugging

# Variables

$ver = "1.5 ALPHA"
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
  puts "In order to use the preview of the calculator, please type your equation in the rows respectively. ONLY USE X AS VARIABLE, DONT USE ANY EXPONENTIALS OR ROOTS AND NO PARANTHESES!! ALSO, USING ANY DECIMAL NUMBERS OR CREATING ANY CALCULATIONS IN WHICH THE ANSWER WILL BE DECIMAL (SUCH AS 5/10) WILL PROBABLY NOT WORK DUE TO A BUG WITH THE EVAL METHOD. THIS IS CURRENTLY NOT FIXABLE"
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
  vlv = vlv.gsub(" ", "")
  vlv = vlv.gsub("*-", "*_")
  vlv = vlv.gsub("/", "~")
  hlv = hlv.gsub(" ", "")
  hlv = hlv.gsub("*-", "*_")
  hlv = hlv.gsub("/", "~")
    
  separation = vlv.split(/(?=[+-])/)

  separation.each do |line|
    line = line.gsub("_", "-")
    line = line.gsub("~", "/")
    if line.index("x") == nil
      puts "ifv"      #DB
      line = eval(line)
      line = line.to_f
      vlvn += line
    elsif line.index("*") == nil and line.index("/") == nil
      puts "elsifv"             #DB
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
      puts "elsev"                 # DEBUG
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
      line = eval(line)
      vlvx += line.to_f
    end
    puts "VLVX per line: #{vlvx}"   #DB
    puts "VLVN per line: #{vlvn}"   #DB
  end

  separation = hlv.split(/(?=[+-])/)
  
  separation.each do |line|
    line = line.gsub("_", "-")
    line = line.gsub("~", "/")
    if line.index("x") == nil
      puts "ifh"                                              # DEBUG
      line = eval(line)
      line = line.to_f
      hlvn += line
    elsif line.index("*") == nil and line.index("/") == nil
      puts "elsifh"                                           # DEBUG
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
      puts "elseh"                                              # DEBUG
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
      line = eval(line)
      hlvx += line.to_f
    end
    puts "HLVX per line: #{hlvx}"   #DB
    puts "HLVN per line: #{hlvn}"   #DB
  end
  
  puts "VLVX: #{vlvx}"
  puts "HLVX: #{hlvx}"
  puts "VLVN: #{vlvn}"
  puts "HLVN: #{hlvn}"
  vlv = vlvx + hlvx*(-1)
  puts "VLV: #{vlv}"    #ENABLE FOR DEBUG
  hlv = hlvn + vlvn*(-1)
  puts "HLV: #{hlv}"    #ENABLE FOR DEBUG
  hlv = hlv/vlv
  vlv = vlv/vlv
  
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