module BookKeeping
  VERSION = 1
end

class Sieve
  def initialize(limit)
    @range = (2..limit).to_a
  end

  def primes
    puts @range.to_s
    counter = 0
    nonprimes = Array.new
    unless @range.index(@range.last) == nil
      while counter <= @range.index(@range.last) do
        nonprimes << @range.select { |i| i % @range[counter] == 0 and i != @range[counter] }
        counter += 1
        nonprimes = nonprimes.flatten.uniq.sort!# sort.each_with_object({}) do |
        prime_nums = @range - nonprimes
      end
      return prime_nums
    end
  end
end
# Sieve.new(1).primes
