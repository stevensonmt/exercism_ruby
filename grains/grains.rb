class Grains
  def self.square(num)
    2**(num-1)
  end

  def self.total
    n = 2
    x = 64
    ((n)**(x+1) - 1)/n
  end

end
#
# puts Grains.square(3)
# puts Grains.total
