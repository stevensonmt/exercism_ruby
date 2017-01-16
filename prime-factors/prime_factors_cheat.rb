class PrimeFactors
  require 'prime'
  def self.for(number)
    factors = number.prime_division
    prime_factors = []
    factors.map { |pf, exp| exp.times do (prime_factors << pf) end }
    prime_factors
  end
end
