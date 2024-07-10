require "http"
# require "tco"
# require "rmagick"

system "clear"
# pokemon = "pikachu" # << Temp. <<
print "Enter Pokémon: "
pokemon = gets.chomp.downcase
# ^^ keep in final code ^^
response = HTTP.get("https://pokeapi.co/api/v2/pokemon/#{pokemon}")
data = response.parse

system "clear"

png = data["sprites"]["versions"]["generation-i"]["red-blue"]["front_default"]

# Magick::Image.read(png).first.each_pixel do |pixel, col, row|
#   c = [pixel.red, pixel.green, pixel.blue].map { |v| 256 * (v / 65535.0) }
#   pixel.alpha == 65535 ? print("  ") : print("  ".bg c)
#   puts if col >= Magick::Image.read(png).first.columns - 1
# end

puts "Pokédex: ##{data["id"]}"
puts "Pokémon: #{data["name"].capitalize}"
if data["types"][1] != nil
  puts "Type: #{data["types"][0]["type"]["name"]}, #{data["types"][1]["type"]["name"]}"
else
  puts "Type: #{data["types"][0]["type"]["name"]}"
end
puts "Ability: #{data["abilities"][0]["ability"]["name"]}"
height = data["height"].to_f / 10
puts "Height: #{height} m"
weight = data["weight"].to_f / 10
puts "Weight: #{weight} kg"

puts "
Base Stats:"
data["stats"].each do |stat|
  puts "#{stat["stat"]["name"]}: #{stat["base_stat"]}"
end

puts "
Level-Up Move List(Version: #{data["moves"][0]["version_group_details"][0]["version_group"]["name"]}):"
ordered_levels = []
data["moves"].each do |move|
  if move["version_group_details"][0]["move_learn_method"]["name"] == "level-up" && move["version_group_details"][0]["version_group"]["name"] == "red-blue"
    ordered_levels << move["version_group_details"][0]["level_learned_at"]
  end
end
ordered_levels = ordered_levels.uniq.sort
ordered_levels.each do |level|
  data["moves"].each do |move|
    if move["version_group_details"][0]["level_learned_at"] == level && move["version_group_details"][0]["version_group"]["name"] == "red-blue"
      puts "Level: #{level}, Move: #{move["move"]["name"]}"
    end
  end
end
