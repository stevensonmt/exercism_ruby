module BookKeeping
  VERSION = 3
end

class Hamming < String
  class << self
#   def compute(a, b)
#     if a.length == b.length
#       (0...a.length).count { |i| a[i] != b[i] }
#     else
#       raise ArgumentError.new('Strands are of unequal length, cannot compare')
#     end
#   end
#   end
# end

def compute(a, b)
  hamdist = 0
  if a.length == b.length
    a.chars.each_index do |i|
    hamdist +=1 if /#{a[i]}/i.match(b[i]).nil?
    end
    hamdist
  else
    raise ArgumentError.new('Strands are of unequal length, cannot compare')
  end
end
end
end
