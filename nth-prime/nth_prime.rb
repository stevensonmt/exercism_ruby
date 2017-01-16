module BookKeeping
  VERSION = 1
end

class Prime
  @primes = [2, 3]

  def self.nth(nth)
    raise ArgumentError if nth < 1

    last_checked = @primes.last + 2
    while @primes.size < nth
      prime?(last_checked)
      last_checked += 2
    end
    @primes[nth-1]

  end

  def self.prime?(n)
    @primes << n if @primes.none?{|prime| n % prime == 0}
  end
end
