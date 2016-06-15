# basic_client.rb -- Chatter Bot
# Beginning Ruby by Peter Cooper - Chapter 12
# http://peterc.org/beginningruby/

require './bot'

bot = Bot.new(:name => 'Fred', :data_file => 'fred.bot')

puts bot.greeting

while input = gets and input.chomp != 'end'
	puts '>> ' + bot.response_to(input)
end

puts bot.farewell