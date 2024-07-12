require "http"
require "tty-prompt"
require "tty-table"
require "io/console"
require "rmagick"
require "artii"
require "pastel"

color = Pastel.new

def title
  color = Pastel.new
  puts color.blue.on_yellow("                                     ,'\\                              ")
  puts color.yellow("      _.----.         ____         ,'  _\\   ___    ___     ____       ")
  puts color.yellow("  _,-'        `.     |    |  /`.   \\,-'    |   \\  /   |   |    \\  |`. ")
  puts color.yellow("  \\      __     \\    '-.  | /   `.  ___    |    \\/    |   '-.   \\ |  |")
  puts color.yellow("   \\.    \\ \\    |  __  |  |/    ,','_  `.  |          | __  |    \\|  |")
  puts color.yellow("     \\    \\/   /,' _ `.|      ,' / / / /   |          ,' _`.|     |  |")
  puts color.yellow("      \\     ,-'/  /    \\    ,'   | \\/ / ,`.|         /  /   \\  |     |")
  puts color.yellow("       \\    \\ |   \\_/   |   `-.  \\    `'  /|  |    ||   \\_/  | |\\    |")
  puts color.yellow("        \\    \\ \\       /       `-.`.___,-' |  |\\  /| \\      /  | |   |")
  puts color.yellow("         \\    \\ `.__,' |  |`-._    `|      |__| \\/ |  `.__,'|  | |   |")
  puts color.yellow("          \\_.-'        |__|    `-._ |              '-.|     '-.| |   |")
  puts color.yellow("                                   `'                            '-._|")
end

system "clear"
title
pokemon = "pikachu" # << Test <<
# print "Enter Pokémon: "
# pokemon = gets.chomp.downcase
# ^^ keep in final code ^^
response = HTTP.get("https://pokeapi.co/api/v2/pokemon/#{pokemon}")
data = response.parse

# Create version selector for moves (and more potentially?) next using tty-prompt
prompt = TTY::Prompt.new
versions = %w(
  Red_and_Blue
  Yellow
  Gold_and_Silver
  Crystal
  Ruby_and_Sapphire
  FireRed_and_LeafGreen
  Emerald
  Colosseum
  XD:_Gale_of_Darkness
  Diamond_and_Pearl
  Platinum
  HeartGold_and_SoulSilver
  Black_and_White
  Black_2_and_White_2
  X_and_Y
  Omega_Ruby_and_Alpha_Sapphire
  Sun_and_Moon
  Ultra_Sun_and_Ultra_Moon
  Let's_Go,_Pikachu!_and_Let's_Go,_Eevee!
  Sword_and_Shield
  Brilliant_Diamond_and_Shining_Pearl
  Scarlet_and_Violet
)

version_choice = prompt.select("Select version:", versions)
version = version_choice

if version == "Red_and_Blue"
  version = "red-blue"
  png = data["sprites"]["versions"]["generation-i"]["red-blue"]["front_default"]
elsif version == "Yellow"
  version = "yellow"
  png = data["sprites"]["versions"]["generation-i"]["yellow"]["front_default"]
elsif version == "Gold_and_Silver"
  version = "gold-silver"
  png = data["sprites"]["versions"]["generation-ii"]["gold"]["front_default"]
elsif version == "Crystal"
  version = "crystal"
  png = data["sprites"]["versions"]["generation-ii"]["crystal"]["front_default"]
elsif version == "Ruby_and_Sapphire"
  version = "ruby-sapphire"
  png = data["sprites"]["versions"]["generation-iii"]["ruby-sapphire"]["front_default"]
elsif version == "FireRed_and_LeafGreen"
  version = "firered-leafgreen"
  png = data["sprites"]["versions"]["generation-iii"]["firered-leafgreen"]["front_default"]
elsif version == "Emerald"
  version = "emerald"
  png = data["sprites"]["versions"]["generation-iii"]["emerald"]["front_default"]
elsif version == "Diamond_and_Pearl"
  version = "diamond-pearl"
  png = data["sprites"]["versions"]["generation-iv"]["diamond-pearl"]["front_default"]
elsif version == "Platinum"
  version = "platinum"
  png = data["sprites"]["versions"]["generation-iv"]["platinum"]["front_default"]
elsif version == "HeartGold_and_SoulSilver"
  version = "heartgold-soulsilver"
  png = data["sprites"]["versions"]["generation-iv"]["heartgold-soulsilver"]["front_default"]
elsif version == "Black_and_White"
  version = "black-white"
  png = data["sprites"]["versions"]["generation-v"]["black-white"]["front_default"]
elsif version == "Black_2_and_White_2"
  version = "black-2-white-2"
  png = data["sprites"]["versions"]["generation-v"]["black-white"]["front_default"]
elsif version == "X_and_Y"
  version = "x-y"
  png = data["sprites"]["versions"]["generation-vi"]["x-y"]["front_default"]
elsif version == "Omega_Ruby_and_Alpha_Sapphire"
  version = "omega-ruby-alpha-sapphire"
  png = data["sprites"]["versions"]["generation-vi"]["omegaruby-alphasapphire"]["front_default"]
elsif version == "Sun_and_Moon"
  version = "sun-moon"
  png = data["sprites"]["versions"]["generation-vii"]["icons"]["front_default"]
elsif version == "Ultra_Sun_and_Ultra_Moon"
  version = "ultra-sun-ultra-moon"
  png = data["sprites"]["versions"]["generation-vii"]["ultra-sun-ultra-moon"]["front_default"]
elsif version == "Let's_Go,_Pikachu!_and_Let's_Go,_Eevee!"
  version = "lets-go-pikachu-lets-go-eevee"
  png = data["sprites"]["versions"]["generation-viii"]["icons"]["front_default"]
elsif version == "Sword_and_Shield"
  version = "sword-shield"
  png = data["sprites"]["versions"]["generation-viii"]["icons"]["front_default"]
elsif version == "Brilliant_Diamond_and_Shining_Pearl"
  version = "brilliant-diamond-and-shining-pearl"
  png = data["sprites"]["versions"]["generation-viii"]["icons"]["front_default"]
elsif version == "Scarlet_and_Violet"
  version = "scarlet-violet"
  png = data["sprites"]["versions"]["generation-viii"]["icons"]["front_default"]
elsif version == "Colosseum"
  version = "colosseum"
  png = data["sprites"]["other"]["showdown"]["front_default"]
elsif version == "XD:_Gale_of_Darkness"
  version = "xd"
  png = data["sprites"]["other"]["showdown"]["front_default"]
end

system "clear"
# Present visuals about Pokemon
# title
a = Artii::Base.new(font: "small")
puts
puts color.on_red(a.asciify("  ##{data["id"]}                             #{data["name"].capitalize}   "))
# "#25        Pikachu"

# Pokemon Sprite
# 1)
# # Method to convert RGB values to an ANSI escape code for background color
# def rgb_to_ansi_bg(r, g, b)
#   "\e[48;2;#{r};#{g};#{b}m"
# end
# # Get the terminal dimensions
# term_width, term_height = IO.console.winsize
# # Read and resize the image
# img = Magick::Image::read(png).first
# img = img.resize_to_fit(term_width, term_height)
# img.each_pixel do |pixel, col, row|
#   c = [pixel.red, pixel.green, pixel.blue].map { |v| (v * 255.0 / 65535.0).round }
#   # Debugging output for color values
#   puts "Pixel at (#{col}, #{row}): R=#{c[0]}, G=#{c[1]}, B=#{c[2]}, Alpha=#{pixel.alpha}" if col % 50 == 0 && row % 50 == 0
#   if pixel.alpha == Magick::OpaqueAlpha
#     print "#{rgb_to_ansi_bg(c[0], c[1], c[2])}  \e[0m"
#   else
#     print "\e[0m  "
#   end
#   puts if col >= img.columns - 1
# end
#
#
#
#
#
#
# 2)
# Method to convert RGB values to an ANSI escape code for background color
def rgb_to_ansi_bg(r, g, b)
  "\e[48;2;#{r};#{g};#{b}m"
end

# Get the terminal dimensions
term_width, term_height = IO.console.winsize

# Read and resize the image
img = Magick::Image::read(png).first

img.each_pixel do |pixel, col, row|
  r, g, b = [pixel.red, pixel.green, pixel.blue].map { |v| (v * 255.0 / 65535.0).round }
  if pixel.alpha == Magick::OpaqueAlpha # Check if the pixel is fully opaque
    print "#{rgb_to_ansi_bg(r, g, b)}  \e[0m"
  else
    print "\e[0m  "
  end
  puts if col >= img.columns - 1
end
#
#
#
#
#
# Pokemon data
puts
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

# Stats Table
puts "
Base Stats:"
statstable = TTY::Table.new(header: ["Stat Name", "Base Stat"])
data["stats"].each do |stat|
  statstable << [stat["stat"]["name"], stat["base_stat"]]
end
puts statstable.render(:unicode)

# Move Table
puts "
Level-Up Move List:
(Version: #{version_choice})"
ordered_levels = []
data["moves"].each do |move|
  move["version_group_details"].each do |level|
    if level["move_learn_method"]["name"] == "level-up" && level["version_group"]["name"] == version
      ordered_levels << level["level_learned_at"]
    end
  end
end
ordered_levels = ordered_levels.uniq.sort

movetable = TTY::Table.new(header: ["Level", "Move"])
data["stats"].each do |stat|
  [stat["stat"]["name"], stat["base_stat"]]
end

ordered_levels.each do |level|
  data["moves"].each do |move|
    move["version_group_details"].each do |s_move|
      if s_move["level_learned_at"] == level && s_move["version_group"]["name"] == version
        movetable << [level, move["move"]["name"]]
      end
    end
  end
end

puts movetable.render(:unicode)
