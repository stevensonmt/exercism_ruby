class Series
  def initialize(series)
    @series = (series)
  end
  def slices(n)
    series = @series
    if n > series.length
      raise ArgumentError
    end
    substrings = []
    until series.length < n
      substrings << series[0..n-1].chars.map(&:to_i)
      series = series[1..-1]
    end
    substrings
  end
end
testing = Series.new('01234')
