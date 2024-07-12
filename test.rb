require "rmagick"
require "io/console"

# Method to convert RGB values to an ANSI escape code for background color
def rgb_to_ansi_bg(r, g, b)
  "\e[48;2;#{r};#{g};#{b}m"
end

# Get the terminal dimensions
term_width, term_height = IO.console.winsize

# Read and resize the image
img = Magick::Image::read("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/132.png").first

img.each_pixel do |pixel, col, row|
  r, g, b = [pixel.red, pixel.green, pixel.blue].map { |v| (v * 255.0 / 65535.0).round }
  if pixel.alpha == Magick::OpaqueAlpha # Check if the pixel is fully opaque
    print "#{rgb_to_ansi_bg(r, g, b)}  \e[0m"
  else
    print "\e[0m  "
  end
  puts if col >= img.columns - 1
end
