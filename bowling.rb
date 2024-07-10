# Set a new variable 'roll' equal to an integer.

# Set a new variable 'roll' equal to an integer, then create a new variable called 'score' which is equal to the value of 'roll', then print 'score' to the user.

# Set a new variable 'roll' equal to a user input which is converted into an integer, then create a new variable called 'score' which is equal to the value of 'roll', then print 'score' to the user.

# Set a new variable 'roll' equal to 2 user inputs which is converted into an integer, then added to each other, then create a new variable called 'score' which is equal to the value of 'roll', then print 'score' to the user.
score = 0
turn = 1
9.times do
  puts "Turn #{turn}!"
  puts "Enter how many pins knocked down in first roll."
  roll1 = gets.chomp.to_i
  if roll1 == 10
    puts "Strike!"
    score = roll1 + score
    turn += 1
  else
    puts "Enter how many pins knocked down in second roll."
    roll2 = gets.chomp.to_i
    if roll1 + roll2 < 0 || roll1 + roll2 > 10
      puts "Try again! There's only 10 pins!"
      puts "Enter how many pins knocked down in first roll."
      roll1 = gets.chomp.to_i
      if roll1 == 10
        puts "Strike!"
        score = roll1 + score
      else
        puts "Enter how many pins knocked down in second roll."
        roll2 = gets.chomp.to_i
      end
    end
    score = roll1 + roll2 + score
    if roll1 + roll2 == 10
      puts "Spare!"
    else
      puts "Your score is #{score}."
    end
    turn += 1
  end
end
puts "Your final score is #{score}!"
