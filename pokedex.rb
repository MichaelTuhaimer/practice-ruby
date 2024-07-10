require "http"
require "tty-prompt"
require "tty-table"
# require "tco"
# require "rmagick"

# pokemon = "pikachu" # << Test <<
system "clear"
print "Enter Pokémon: "
pokemon = gets.chomp.downcase
# ^^ keep in final code ^^
response = HTTP.get("https://pokeapi.co/api/v2/pokemon/#{pokemon}")
data = response.parse

system "clear"

png = data["sprites"]["versions"]["generation-i"]["red-blue"]["front_default"]

# img = Magick::Image.read(png).first
# img.each_pixel do |pixel, col, row|
#   c = [pixel.red, pixel.green, pixel.blue].map { |v| 256 * (v / 65535.0) }
#   pixel.alpha == 65535 ? print("  ") : print("  ".bg c)
#   puts if col >= img.columns - 1
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

statstable = TTY::Table.new(header: ["Stat Name", "Base Stat"])
data["stats"].each do |stat|
  statstable << [stat["stat"]["name"], stat["base_stat"]]
end
puts statstable.render(:unicode)

puts "
Level-Up Move List:
(Version: #{data["moves"][0]["version_group_details"][0]["version_group"]["name"]})"
ordered_levels = []
data["moves"].each do |move|
  if move["version_group_details"][0]["move_learn_method"]["name"] == "level-up" && move["version_group_details"][0]["version_group"]["name"] == "red-blue"
    ordered_levels << move["version_group_details"][0]["level_learned_at"]
  end
end
ordered_levels = ordered_levels.uniq.sort

movetable = TTY::Table.new(header: ["Level", "Move"])
data["stats"].each do |stat|
  [stat["stat"]["name"], stat["base_stat"]]
end

ordered_levels.each do |level|
  data["moves"].each do |move|
    if move["version_group_details"][0]["level_learned_at"] == level && move["version_group_details"][0]["version_group"]["name"] == "red-blue"
      movetable << [level, move["move"]["name"]]
    end
  end
end

puts movetable.render(:unicode)

# Create version selector for moves next using tty-prompt
