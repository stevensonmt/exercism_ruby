class ETL
  def self.transform(old)
    old.flat_map { |k, v| v.map!{|i| i.downcase}.product([k]) }.to_h
  end
end
