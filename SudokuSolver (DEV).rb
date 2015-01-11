### SUDOKU SOLVER 0.7_DEV ###

# Things to do:
#
# - Clean up code
# - Add error exceptions
# - Make UI understandable
# - Create sudoku generator
# - Add more simple way to input nums to sudoku (let user write in each square, and tab through them with enter)
# - Write code to solve harder sudokus!!! 

# Functions:

def mainSheet # Add sudoku defaults after hashes to run them
  hashes
  puts
  sudokuGUI(0.3)
  terminal
end

def hashes
  $positions = Hash.new
  $possibles = Hash.new
  for y in 1..9
    for x in 1..9
      $possibles["#{x},#{y}"] = "123456789"
	end
  end
end

def easySudoku # Solve == true
  $positions["3,1"] = 4
  $positions["4,1"] = 2
  $positions["6,1"] = 5
  $positions["8,1"] = 6
  $positions["1,2"] = 6
  $positions["2,2"] = 2
  $positions["8,2"] = 3
  $positions["2,3"] = 7
  $positions["4,3"] = 9
  $positions["9,3"] = 5
  $positions["1,4"] = 1
  $positions["2,4"] = 3
  $positions["3,4"] = 9
  $positions["5,4"] = 7
  $positions["1,5"] = 5
  $positions["5,5"] = 8
  $positions["9,5"] = 3
  $positions["5,6"] = 1
  $positions["7,6"] = 6
  $positions["8,6"] = 7
  $positions["9,6"] = 9
  $positions["1,7"] = 7
  $positions["6,7"] = 1
  $positions["8,7"] = 4
  $positions["2,8"] = 1
  $positions["8,8"] = 9
  $positions["9,8"] = 6
  $positions["2,9"] = 5
  $positions["4,9"] = 3
  $positions["6,9"] = 6
  $positions["7,9"] = 1
end

def vHardSudoku # Solve == false
  $positions["3,1"] = 7
  $positions["6,1"] = 1
  $positions["9,1"] = 5
  $positions["3,2"] = 5
  $positions["4,2"] = 4
  $positions["7,2"] = 3
  $positions["8,2"] = 7
  $positions["9,2"] = 1
  $positions["7,3"] = 4
  $positions["8,3"] = 8
  $positions["4,4"] = 7
  $positions["5,4"] = 9
  $positions["7,4"] = 8
  $positions["9,4"] = 2
  $positions["2,5"] = 9
  $positions["8,5"] = 3
  $positions["1,6"] = 2
  $positions["3,6"] = 3
  $positions["5,6"] = 8
  $positions["6,6"] = 5
  $positions["2,7"] = 8
  $positions["3,7"] = 4
  $positions["1,8"] = 7
  $positions["2,8"] = 5
  $positions["3,8"] = 2
  $positions["6,8"] = 4
  $positions["7,8"] = 6
  $positions["1,9"] = 1
  $positions["4,9"] = 2
  $positions["7,9"] = 7
end

def sqDefChk(i, i2, gx)
  numming = false
  gy =(i * 3 - 3) + i2
  $positions.each do |key, value|
    x, y = key.split(",")
    if x.to_i == gx.to_i and y.to_i == gy.to_i
      if value.to_s.downcase == "c"
        return " "
      else
        return value.to_s
      end
      numming = true
    end
    if value.to_s.downcase == "c"
      $positions.delete(key)
    end
  end
  if numming == false
    return " "
  end
end

def solveSudoku
  count = 0 #TMP
  #until $possibles.empty? == true   # SOLVE!!!
  until count == 2000  #TMP
	count += 1 #TMP
	for y in 1..9
      for x in 1..9
	    if not $positions.has_key?("#{x},#{y}")
	      x2 = x
		  y2 = y
	      for numchk in 1..9
		    ftc = $positions.fetch("#{x},#{numchk}", nil)	#FUNCT?
		    if ftc != nil
              ftc2 = $possibles.fetch("#{x},#{y}")
			  ftc2 = ftc2.gsub("#{ftc}", "")
		      $possibles["#{x},#{y}"] = ftc2
		    end
		    fte = $positions.fetch("#{numchk},#{y}", nil)	#FUNCT?
		    if fte != nil
		      fte2 = $possibles.fetch("#{x},#{y}")
			  fte2 = fte2.gsub("#{fte}", "")
			  $possibles["#{x},#{y}"] = fte2
		    end
		  end
		  if x2 < 4				# BETTER?
		    x2 = 0
		  elsif x2 < 7
		    x2 = 3
		  else
		    x2 = 6
		  end
		  if y2 < 4
		    y2 = 0
		  elsif y2 < 7
		    y2 = 3
		  else
		    y2 = 6
		  end						# /BETTER?
	      for ysqchk in 1..3
            for xsqchk in 1..3				#FUNCT?
		      ftg = $positions.fetch("#{x2+xsqchk},#{y2+ysqchk}", nil)
			  if ftg != nil
			    ftg2 = $possibles.fetch("#{x},#{y}")
			    ftg2 = ftg2.gsub("#{ftg}", "")
			    $possibles["#{x},#{y}"] = ftg2
			  end
		    end
		  end
        end
	  end
    end
	$possibles.each do |key, value|							# use of each_value possible?  
      if value.to_i < 10  
	    solve = true
		x, y = key.split(",")
        $positions["#{x},#{y}"] = value
	    $possibles.delete(key)
      end
	end
  end
  sudokuGUI(0)
  sleep(1000)
end  
  
def sqDefReg(x, y, pnum)
  $positions["#{x},#{y}"] = pnum
end

def sudokuGUI(scrspd)
  puts "     1   2   3   4   5   6   7   8   9"
  sleep(scrspd)
  for i in 1..3
    puts "   ====================================="
    sleep(scrspd)
    for i2 in 1..2
      print " #{((i-1)*3)+i2} I #{sqDefChk(i, i2, 1)} | #{sqDefChk(i, i2, 2)} | #{sqDefChk(i, i2, 3)} I #{sqDefChk(i, i2, 4)} | #{sqDefChk(i, i2, 5)} | #{sqDefChk(i, i2, 6)} I #{sqDefChk(i, i2, 7)} | #{sqDefChk(i, i2, 8)} | #{sqDefChk(i, i2, 9)} I \n"
      sleep(scrspd)
      puts      "   I-----------I-----------I-----------I"
      sleep(scrspd)
    end
    i2 = 3
    print " #{i*3} I #{sqDefChk(i, i2, 1)} | #{sqDefChk(i, i2, 2)} | #{sqDefChk(i, i2, 3)} I #{sqDefChk(i, i2, 4)} | #{sqDefChk(i, i2, 5)} | #{sqDefChk(i, i2, 6)} I #{sqDefChk(i, i2, 7)} | #{sqDefChk(i, i2, 8)} | #{sqDefChk(i, i2, 9)} I \n"
    sleep(scrspd)
  end
  puts "   ====================================="
  sleep(scrspd)
  puts
end

def terminal
  print "                                                                               " #TMP
  print "\r"                                                                  #TMP
  print "Coordinates and number [x, y, num (all 1-9)]: "
  put = gets.chomp
  if put.downcase == "exit"
    exit
  elsif put.downcase == "solve" #TEMP
    print "\033[22A"
    print "\r"
    solveSudoku
    exit    #FIXING
  end
  x, y, pnum = put.split(",")
  until x.to_i > 0 and x.to_i < 10 and y.to_i > 0 and y.to_i < 10 and pnum.to_i > 0 and pnum.to_i < 10 or pnum.downcase == "c" # BETTER
    for i in 1..3
      print "\a"
    end
    print "\033[1A"
    print "\r"
    print "                                                                               "
    print "\r"
    print "Coordinates and number [x, y, num (all 1-9)]: "
    x, y, pnum = gets.chomp.split(",") # UI
  end
  sqDefReg(x.to_i, y.to_i, pnum)
  print "\033[22A"
  print "\r"
  sudokuGUI(0)    # TEMP CODE!!!!!
  terminal
end

# Runcode:

mainSheet