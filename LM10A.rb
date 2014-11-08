####################   LOGIMAT 1.2 ALPHA        EQUATION CALCULATOR ####################

#   BUGS:
#
#   - EVAL DOES NOT CALCULATE PROPERLY (I.E 1/5 = 0 != true)
#   - HAVING A SINGLE X AS THE FIRST CHAR (0) WHEN LINE GOES THROUGH SINGLE OR SEVERAL X'S CHECK IN CALCVC CAUSES PROBLEMS, AS THE LAST CHAR IN THE STRING WILL BE READ IN ORDER
#     TO DETERMINE IF X IS SINGLE OR NOT. EXCEPTION IS REQUIRED FOR THIS
#   - LOADS OF OTHER PROBLEMS

# Variables

$ver = "1.2 ALPHA"
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
    sel = gets.chomp
    until sel == "y" or sel == "Y" or sel == "n" or sel == "N"
      puts
      puts "You have typed an invalid letter. Try again!"
      puts
      sel = gets.chomp
    end
    if sel == "Y" or sel == "y"
      puts
      puts "Please state which function you would like to use by typing the letter in front of the corresponding function:"
    elsif sel == "n" or sel == "N"
      puts
      puts
      puts "Ok, bye bye!"
      sleep (2)
      exit
    end
  end
  puts
  puts "(D) Difference calculator (calculates different between two sides)"
  puts "(V) Variable calculator (calculates the value of a specified variable within the equation."
  puts "(E) Exit (terminates the program)"
  sel = gets.chomp
  until sel == "d" or sel == "D" or sel == "v" or sel == "V" or sel == "e" or sel == "E"
    puts
    puts "You have typed an invalid letter. Try again!"
    puts
    sel = gets.chomp
  end
  if sel == "d" or sel == "D"
    puts "Starting DC (Difference Calculator)..."
    sleep(1)
    getInputDC
  elsif sel == "v" or sel == "V"
    puts "Starting VC (Variable Calculator)..."
    sleep(1)
    getInputVC
  elsif sel == "e" or sel == "E"
    puts "Bye bye!"
    sleep (2)
    puts
  end
end

def getInputDC
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
  puts "In order to use the preview of the calculator, please type your equation in the rows respectively. ONLY USE X AS VARIABLE AND NO PARANTHESES!! ALSO, USING ANY DECIMAL NUMBERS OR CREATING ANY CALCULATIONS IN WHICH THE ANSWER WILL BE DECIMAL (SUCH AS 5/10) WILL PROBABLY NOT WORK DUE TO A BUG WITH THE EVAL METHOD. THIS IS CURRENTLY NOT FIXABLE"
  puts "Please enter the left row:"
  vlv = gets.chomp
  puts "The left row specified is: #{vlv}."
  puts
  puts "Please enter the right row:"
  hlv = gets.chomp
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
    line = line.gsub("_", "-")
        
    if line.index("x") == nil and line.index("X") == nil
      line = eval(line)
      line = line.to_f
      vlvn += line
    elsif line.index("*") == nil and line.index("/") == nil
      line = line.to_f
      if line == 0
        vlvx += 1
      else
        vlvx += line
      end 
    else    
      while line.index("x") != nil
        np = line.index("x") - 1
        if line[np].to_f != 0
          line = line.sub("x", "")
        else
          line = line.sub("x", "1")
        end
      end
      line = eval(line)
      hlvx += line.to_f
    end
  end

  separation = hlv.split(/(?=[+-])/)
  
  separation.each do |line|
    line = line.gsub("_", "-")
    line = line.gsub("~", "/")
    line = line.gsub("_", "-")
    if line.index("x") == nil and line.index("X") == nil
      line = eval(line)
      line = line.to_f
      hlvn += line
    elsif line.index("*") == nil and line.index("/") == nil
      line = line.to_f
      if line == 0
        hlvx += 1
      else
        hlvx += line
      end
    else
      while line.index("x") != nil
        np = line.index("x") - 1
        if line[np].to_f != 0
          line = line.sub("x", "")
        else
          line = line.sub("x", "1")
        end
      end
      line = eval(line)
      hlvx += line.to_f
    end
  end
  
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





















