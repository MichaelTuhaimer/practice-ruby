# Create a banking program that asks the user 5 times to enter a first name, last name, and email. This information should be stored as an array of hashes.

# Each person should automatically be given an account number which is a randomized ten digit number.

# After the user is finished, the program should print out all the users. For example:

# FIRST NAME: Joan
# LAST NAME: Kelson
# EMAIL: jkelson@juno.com
# ACCT #: 2372041038

# and so on for all the users.

arr = []
5.times do
  hash = {}
  puts "Enter a first name:"
  hash[:first_name] = gets.chomp
  puts "Enter a last name:"
  hash[:last_name] = gets.chomp
  puts "Enter an email address:"
  hash[:email] = gets.chomp
  arr << hash
end

puts ""
arr.each do |person|
  person[:account_number] = rand(10 ** 10)
  puts "FIRST NAME: #{person[:first_name].capitalize}"
  puts "LAST NAME: #{person[:last_name].capitalize}"
  puts "EMAIL: #{person[:email]}"
  puts "ACCT #: #{person[:account_number]}"
  puts ""
end
