module BookKeeping
  VERSION = 2
end

class Anagram

  def initialize(word)
    @word = word.downcase
  end

  def match(candidates)
    candidates.select { |i|  anagram?(i.downcase) }
  end

  def anagram?(candidate)
    candidate.chars.sort == @word.chars.sort && candidate != @word
  end
end
