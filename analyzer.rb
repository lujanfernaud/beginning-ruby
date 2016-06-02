# analyzer.rb -- Text Analyzer
# Beginning Ruby by Peter Cooper - Chapter 4
# http://peterc.org/beginningruby/

stopwords = %w{the a by on for of are with just but and to the my I has some in}

# Get the text and count lines
lines = File.readlines(ARGV[0])
line_count = lines.size
text = lines.join

# Count the characters
character_count = text.length
character_count_nospaces = text.gsub(/\s+/, "").length

# Count the words, sentences, and paragraphs
word_count = text.split.length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length

# Make a list of words that aren't stop words,
# count them, and work out the percentage against good words
all_words = text.scan(/\w+/)
good_words = all_words.select { |word| !stopwords.include?(word) }
good_percentage = ((good_words.length.to_f / all_words.length.to_f) * 100).to_i

# Summarize the text
sentences = text.gsub(/\s+/, " ").strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

# Get the filename and filename length
filename = ARGV[0]
filename_length = ARGV[0].length

# Set column width 
column_width = 38

# Give the analysis back
puts 
puts "----------------#{"-" * filename_length}"
puts "Text Analyzer - #{filename}"
puts "----------------#{"-" * filename_length}"
puts
puts "Lines:".ljust(column_width) + "#{line_count}"
puts "Characters:".ljust(column_width) + "#{character_count}"
puts "Characters excluding spaces:".ljust(column_width) + "#{character_count_nospaces}"
puts "Words:".ljust(column_width) + "#{word_count}"
puts "Sentences:".ljust(column_width) + "#{sentence_count}"
puts "Paragraphs:".ljust(column_width) + "#{paragraph_count}"
puts "Sentences per paragraph (average):".ljust(column_width) + "#{sentence_count / paragraph_count}"
puts "Words per sentence (average):".ljust(column_width) + "#{word_count / sentence_count}"
puts "Non stop words:".ljust(column_width) + "#{good_percentage}%"
puts
puts "Summary:\n\n" + ideal_sentences.join(". ") + "."
puts
puts "-- End of analysis"