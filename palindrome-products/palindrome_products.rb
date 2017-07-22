# palindrome products and stuff
class Palindromes
  def initialize(**args)
    @max_factor = args[:max_factor]
    @min_factor = args[:min_factor] || 1
    @palindrome_factors = []
  end

  def generate
    factor_pool = (@min_factor..@max_factor).to_a
    factors = factor_pool.product(factor_pool)
    @palindrome_factors = factors.select do |pair|
      palindrome?(pair)
    end
    @palindrome_factors = deduplicate_factors(@palindrome_factors)
  end

  def largest
    @palindrome_factors.select do |factors|
      product(factors) == product(@palindrome_factors[-1])
    end
  end

  def smallest
    @palindrome_factors.select do |factors|
      product(factors) == product(@palindrome_factors[0])
    end
  end

  private

  def palindrome?(factors)
    prod = product(factors)
    prod = prod.to_s
    prod == prod.reverse
  end

  def deduplicate_factors(palindrome_factors)
    palindrome_factors.sort_by { |factors| product(factors) }
                      .map(&:sort!)
                      .uniq!
  end

  def product(factors)
    factors[0] * factors[1]
  end
end

# extend array class
class Array
  def value
    self[0][0] * self[0][1]
  end

  def factors
    self
  end
end
