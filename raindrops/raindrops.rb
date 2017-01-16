module BookKeeping
  VERSION = 3
end

class Raindrops
  RAINDROPS = {
    3 => 'Pling', 5 => 'Plang', 7 => 'Plong'
  }.freeze

  def self.convert(num)
    sounds = ''
    RAINDROPS.each do |factor, word|
      if num % factor == 0
        sounds << word
      end
    end
    if sounds.empty?
      num.to_s
    else
      sounds
    end
  end
end
