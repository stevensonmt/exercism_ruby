class Meetup
  require 'date'

  DAYS = {
    :sunday => 0,
    :monday => 1,
    :tuesday => 2,
    :wednesday => 3,
    :thursday => 4,
    :friday => 5,
    :saturday => 6
  }

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)

      case schedule
      when :first
        day = 1
      when :second
        day = 8
      when :third
        day = 15
      when :fourth
        day = 22
      when :last
        day = Date.new(@year, @month, -1).day - 6
      when :teenth
        day = 13
      end
      wday = Date.new(@year, @month, day).wday
      offset = (DAYS[weekday] - wday) % 7
      day += offset

    Date.new(@year, @month, day)
  end


end
