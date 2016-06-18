# basic_client_b2b.rb -- Chatter Bot
# Beginning Ruby by Peter Cooper - Chapter 12
# http://peterc.org/beginningruby/

require './bot'

# Two bots talking to each other

fred = Bot.new(:name => "Fred", :data_file => "fred.bot")
chris = Bot.new(:name => "Chris", :data_file => "fred.bot")

def random_sleep
	sleep 1.5 + rand(2.7)
end

r = fred.greeting
10.times do
	puts "#{fred.name} says: " + r
	random_sleep
	r = chris.response_to(r)
	puts "#{chris.name} says: " + r
	random_sleep
	r = fred.response_to(r)
end