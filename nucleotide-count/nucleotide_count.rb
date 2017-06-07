class Nucleotide

  DEFAULTS = {"A" => 0, "C" => 0, "G" => 0, "T" => 0}

  def self.from_dna(input)
    h = input.chars.sort.group_by{|i| i}
    h.each{|k,v| h[k] = v.size }
    h = DEFAULTS.merge(h)
    Nucleotide.new(h)
  end

  def initialize(counts)
    @counts = counts
    raise ArgumentError if DEFAULTS.keys != @counts.keys
  end

  def count(ltr)
    @counts[ltr]
  end


  def histogram
    @counts
  end

end
