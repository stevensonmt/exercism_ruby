module BookKeeping
  VERSION = 5
end

class Gigasecond
  def self.from(dob)
    result = dob + (10**9)
  end

end
