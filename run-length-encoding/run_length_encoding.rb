module BookKeeping
  VERSION = 2
end

class RunLengthEncoding
  def self.encode input
    counted = input.chars.chunk{|i| i}.map{|i, a| [a.size, i]}
    counted.flatten!.delete(1)
    counted.join
  end

  def self.decode(input)
    input.scan(/(\d*)(.)/).reduce('') do |output, (num, char)|
      multiplier = num.empty? ? 1 : num.to_i
      output + (char * multiplier)
    end
  end
end
