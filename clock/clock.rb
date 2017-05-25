module BookKeeping
  VERSION = 2
end

class Clock

  attr_accessor :time

  def initialize(time)
    @time = time
  end

  def self.at(hours, minutes)
    time = (hours*60 + minutes)%1440
    new(time)
  end

  def +(minutes)
    self.class.new(time + minutes)
  end

  def to_s

    hourstring = (time/60).floor % 24
    minutestring = time % 60

    "#{hourstring.to_s.rjust(2,'0')}:#{minutestring.to_s.rjust(2, '0')}"

  end

  def ==(clock)
    clock.class == Clock ? time == clock.time : false
  end

end
