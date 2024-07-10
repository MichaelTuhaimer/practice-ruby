require "http"
require "tty-prompt"

prompt = TTY::Prompt.new

puts "What city would you like to know the forecast in?"
city = gets.chomp.downcase
choices = %w(standard metric imperial)
units = prompt.select("What units do you prefer?", choices)
response = HTTP.get("https://api.openweathermap.org/data/2.5/forecast?q=#{city}&units=#{units}&appid=#{ENV["OPEN_WEATHER_API_KEY"]}")
data = response.parse

system "clear"
# puts
# puts "Today in #{data["name"]}, there is a low of #{data["main"]["temp_min"].round} degrees, with a high of #{data["main"]["temp_max"].round} degrees with #{data["weather"][0]["description"]}."
# puts

# Group data points by day
daily_data = {}
data["list"].each do |entry|
  date = Date.parse(Time.at(entry["dt"]).to_s)
  daily_data[date] ||= []
  daily_data[date] << entry
end

# Calculate daily metrics
daily_forecast = {}
daily_data.each do |date, entries|
  temps = entries.map { |entry| entry["main"]["temp"] }
  descriptions = entries.map { |entry| entry["weather"][0]["description"] }
  daily_forecast[date] = {
    avg_temp: temps.sum / temps.size,
    max_temp: temps.max,
    min_temp: temps.min,
    description: descriptions.group_by(&:itself).values.max_by(&:size).first,
  }
end

# Print daily forecast
daily_forecast.each do |date, forecast|
  puts "Date: #{date}"
  puts "Average Temp: #{forecast[:avg_temp].round}"
  puts "Max Temp: #{forecast[:max_temp].round}"
  puts "Min Temp: #{forecast[:min_temp].round}"
  puts "Weather: #{forecast[:description]}"
  puts
end
