# bot.rb -- Chatter Bot
# Beginning Ruby by Peter Cooper - Chapter 12
# http://peterc.org/beginningruby/

require 'yaml'
require './wordplay'

class Bot
	attr_reader :name

	# Initializes the bot object, loads external YAML data
	# file and sets the bot's name.
	def initialize(options)
		@name = options[:name] || "Unnamed Bot"
		begin
			@data = YAML.load(File.read(options[:data_file]))
		rescue
			raise "Can't load bot data"
		end
	end

	# Returns a random greeting from the bot's data file
	def greeting
		random_response :greeting
	end

	# Returns a random farewell from the bot's data file
	def farewell
		random_response :farewell
	end

	# Responds to input text
	def response_to(input)
		prepared_input = preprocess(input).downcase
		sentence = best_sentence(prepared_input)
		responses = possible_responses(sentence)
		responses[rand(responses.length)]
	end

	private

	# Chooses a random response phrase from the :responses hash
	def random_response(key)
		@data[:responses][key].sample.gsub(/\[name\]/, @name)
	end

	# Performs preprocessing tasks upon all input
	def preprocess(input)
		perform_substitutions(input)
	end

	# Substitutes words and phrases as dictated by :presubs data
	def perform_substitutions(input)
		@data[:presubs].each { |s| input.gsub!(s[0], s[1]) }
		input
	end

	# We search for the sentence that uses the most single
	# word keys from :responses
	def best_sentence(input)
		hot_words = @data[:responses].keys.select do |k|
			k.class == String && k =~ /^\w+$/
		end

		WordPlay.best_sentence(input.sentences, hot_words)
	end

	# Collect all responses that could be used
	def possible_responses(sentence)
		responses = []

		# Find all patters to try to match against
		@data[:responses].keys.each do |pattern|
			next unless pattern.is_a?(String)

			# For each pattern, see if the supplied sentence contains
			# a match. Remove substitution symbols (*) before checking.
			# Push all responses to the responses array.
			if sentence.match('\b' + pattern.gsub(/\*/, '') + '\b')
				# If the pattern contains substitution placeholders,
				# perform the substitutions
				if pattern.include?('*')
					responses << @data[:responses][pattern].collect do |phrase|
						# Erase everything before the placeholder
						matching_section = sentence.sub(/^.*#{pattern}\s+/, '')
						# Substitue the text after the placeholder
						phrase.sub('*', WordPlay.switch_pronouns(matching_section))
					end
				else
					# No placeholders?
					responses << @data[:responses][pattern]
				end
			end
		end

		# If there were no matches, add the default ones
		responses << @data[:responses][:default] if responses.empty?

		# Flatten the blocks of responses to a flat array
		responses.flatten
	end
end