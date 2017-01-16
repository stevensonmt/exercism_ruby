class Bob

  def self.hey(remark = "")
    if remark.scan(/[a-z]/).empty? && !remark.scan(/[A-Z]/).empty?
       "Whoa, chill out!"
    elsif remark.chars.last == "?"
       "Sure."
    elsif remark.split.empty?
       "Fine. Be that way!"
    else
       "Whatever."
    end
  end
end
