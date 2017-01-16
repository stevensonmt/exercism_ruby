module BookKeeping
  VERSION = 1
end

class Phrase
  def initialize(phrase)
    @phrase = phrase.downcase
  end

  def word_count
    clean_phrase = @phrase.gsub(/( '|' | "|" )/, ' ')
    phrase = clean_phrase.scan(/[\w']+/)
    phrase.inject(Hash.new(0)) { |count, word| count[word] += 1 ; count}
  end
end

# testing = Phrase.new("something something test")
# puts testing.word_count
