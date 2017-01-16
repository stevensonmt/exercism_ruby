class Binary
  def self.to_decimal(input)
    if input.chars.all? { |i| i == "0" || i == "1"}
      hash = input.size.times.zip(input.reverse.chars).to_h
      hash.inject(0) { |sum, (_,value)| sum += value.to_i*2**_ ; sum }
    else
      raise ArgumentError
    end
  end
end

module BookKeeping
  VERSION = 3
end
