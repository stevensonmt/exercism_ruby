class Meetup
  require 'date'
  DATES = (1..31).to_a
  MONTHS_WITH_31 = [1,3,5,7,8,10,12]
  DAYS = [ "sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday" ]

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    month_hash = month_hash(@year, @month)
    case schedule
    when :first
      day = month_hash[weekday][0]
    when :second
      day = month_hash[weekday][1]
    when :third
      day = month_hash[weekday][2]
    when :fourth
      day = month_hash[weekday][3]
    when :last
      day = month_hash[weekday][-1]
    when :teenth
      month_hash[weekday].each do |date|
        if date > 12 && date < 20
          day = date
        end
      end
    end
    Date.new(@year, @month, day)
  end

private

  def month_hash(year, month)
    month_hash = {}

    dates = days_in_month(month, year)

    DAYS.each_with_index do |day, ndx|
      dates.each do |date|
        if Date.new(year, month, date).wday == ndx
          if month_hash[day.to_sym].nil?
            month_hash[day.to_sym] = [date]
          else
            month_hash[day.to_sym] << date
          end
        end
      end

    end
    month_hash
  end

  def days_in_month(month, year)
    if MONTHS_WITH_31.include?(month)
      dates = DATES
    elsif month == 2
      if Date.leap?(year)
        dates = DATES - [30, 31]
      else
        dates = DATES - [29, 30, 31]
      end
    else
      dates = DATES - [31]
    end
    dates
  end

end
