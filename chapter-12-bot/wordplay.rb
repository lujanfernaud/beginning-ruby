# wordplay.rb -- Chatter Bot
# Beginning Ruby by Peter Cooper - Chapter 12
# http://peterc.org/beginningruby/

class String
	def sentences
		gsub(/\n|\r/, " ").split(/\.\s*/)
	end

	def words
		scan(/\w[\w\'\-']*/)
	end
end

class WordPlay
	def self.switch_pronouns(text)
		text.gsub(/\b(I am|You are|I|You|Me|Your|My)\b/i) do |pronoun|
			case pronoun.downcase
				when "i" then "you"
				when "you" then "me"
				when "me" then "you"
				when "i am" then "you are"
				when "you are" then "I am"
				when "your" then "my"
				when "my" then "your"
			end
		end.sub(/^me\b/i, "i")
	end

	def self.best_sentence(sentences, desired_words)
		ranked_sentences = sentences.sort_by do |s|
			s.words.length - (s.downcase.words - desired_words).length
		end

		ranked_sentences.last
	end
end