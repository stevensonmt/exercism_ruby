module BookKeeping
  VERSION = 2
end

class Robot
  attr_reader :name
  LETTERS = ("A".."Z").to_a
  DIGITS = (0..9).to_a.map(&:to_s)
  @@names = []

  def initialize
    @name = create_name
    if @@names.include? @name
      @name = create_name
    else
      @@names << name
    end
  end

  def reset
    @name = create_name
  end

  def name
    @name
  end

  def create_name
    suggested_name = ""
    counter = 0
    while counter < 5
      while counter < 2
        letter = Random.rand(26)
        suggested_name << LETTERS[letter]
        counter += 1
      end
      digit = Random.rand(10)
      suggested_name << DIGITS[digit]
      counter += 1
    end
    suggested_name
  end
end
