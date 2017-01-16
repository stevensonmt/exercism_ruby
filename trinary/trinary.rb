module BookKeeping
  VERSION = 1
end

class Trinary < String
  def self.initialize(string)
    @string = string
  end

  def to_decimal
    if self.scan(/[0-2]/).join == self
      self.chars.reverse.map.with_index { |dig, index| dig.to_i*(3**index) }.reduce(:+)
    else
      0
    end
  end
end
