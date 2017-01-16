module BookKeeping
  VERSION = 3
end

class Hamming
  class << self
  def compute(a, b)
    if a.length == b.length
      (0...a.length).count { |i| a[i] != b[i] }      
    else
      raise ArgumentError.new('Strands are of unequal length, cannot compare')
    end
  end
  end
end
