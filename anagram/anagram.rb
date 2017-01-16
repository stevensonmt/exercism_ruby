module BookKeeping
  VERSION = 2
end

class Anagram

  def initialize(word)
    @word = word.downcase
  end

  def match(candidates)
    candidates.select { |i|  anagram?(i) }
  end

  def anagram?(candidate)
    candidate.downcase.chars.sort == @word.chars.sort && candidate.downcase != @word
  end
end
