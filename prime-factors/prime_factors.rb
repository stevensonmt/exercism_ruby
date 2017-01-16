class PrimeFactors
  @@primeseed = [2, 3]

  def self.nth(nth)
    if nth < 1
      @primes = nil
    else
      @primes = @@primeseed
      last_checked = @primes[-1] + 2
      while @primes.size < nth
        prime?(last_checked)
        last_checked += 2
      end
      @primes[nth-1]
    end

  end

  def self.prime?(n)
    @@primeseed << n if @@primeseed.none?{|prime| n % prime == 0}
    @@primeseed
  end



  def self.for(number)
    self.nth(Math.sqrt(number))
    primes = @primes
    factors = []
    factored = number
    if number == 1
      factors
    else
      primes.each do |i|
        while factored % i == 0
          factors << i
          factored /= i
          break if factored == 1
        end
      end
      factors
    end
  end


end
