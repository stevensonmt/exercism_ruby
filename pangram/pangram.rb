module BookKeeping
  VERSION = 3
end

class Pangram
  def self.pangram?(phrase)
    true unless ('a'..'z').any? { |i| phrase.downcase.gsub(/[^a-z]/i, '').index(i).nil? }
  end
end
