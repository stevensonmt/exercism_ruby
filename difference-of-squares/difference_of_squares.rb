module BookKeeping
  VERSION = 3
end

class Squares
  def initialize(n)
    @n = n
  end
  def sum_of_squares
    (0..@n).reduce { |sum, i| sum + i**2 }
  end
  def square_of_sum
    (0..@n).reduce(:+)**2
  end
  def difference
    (self.square_of_sum - self.sum_of_squares)
  end
end
