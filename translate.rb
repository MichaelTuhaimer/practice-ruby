# Translate the following into ruby code. Run the program to make sure it works:

# Sam enjoys cooking. Make an array with recipe names to represent the different recipes Sam can cook.
# Sally speaks many languages. Make an array with language names to represent the languages Sally can speak.
# If Sam can cook more than 10 recipes and Sally speaks more than 5 languages, they should date. Based on the above arrays, print out a message describing whether or not they should date.
# If Sam can make crepes or Sally can speak French, they should marry. Based on the above arrays, print out a message describing whether or not they should marry.

recipe = ["Baked Fish", "Fried Chicken", "Smoked Ribs"]
languages = ["German", "French", "Spanish"]

if recipe.length > 10 && languages.length < 5
  puts "Sally and Sam should date!"
else
  puts "Sally and Sam should not date!"
end

index = 0
while index < recipe.length || index < languages.length
  if recipe[index] == "crepes" || languages[index] == "French"
    puts "Sam and Sally should get married"
    break
  end
  index = index + 1
end
