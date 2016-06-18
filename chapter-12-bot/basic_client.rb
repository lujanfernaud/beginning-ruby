# basic_client.rb -- Chatter Bot
# Beginning Ruby by Peter Cooper - Chapter 12
# http://peterc.org/beginningruby/

require './bot'

bot = Bot.new(:name => ARGV[0], :data_file => ARGV[1])

puts ">> " + bot.greeting.to_s

while input = $stdin.gets and input.chomp != "end"
	puts ">> " + bot.response_to(input)
end

puts ">> " + bot.farewell.to_s

# ruby basic_client.rb <bot name> <data file>
# Example: ruby basic_client.rb Fred fred.bot