# Create a program that asks the user for their favorite 5 foods. Then display those foods as an array, using the p keyword.

foods = []
5.times do
  puts "Enter your favorite food"
  food = gets.chomp
  foods.push(food)
end

p foods

# Now, instead of printing out the array, output 5 separate lines of each food, with the prefix, "I love". For example:

foods.each do |food|
  puts "I love #{food}"
end

# Finally, change your program so that when the list is printed in the terminal, each food is prefaced with a number, beginning with 1 and going up to 5, for example:

# 1.  cobb salad
# 2.  spaghetti
# 3.  pizza
# 4.  Swedish meatballs
# 5.  mac and cheese

index = 0
while index < foods.length
  puts "#{index + 1}. #{foods[index]}"
  index = index + 1
end
