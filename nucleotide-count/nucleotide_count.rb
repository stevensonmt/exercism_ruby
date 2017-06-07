class Nucleotide

  NUCLEOTIDES = ["A", "G", "C", "T"]

  def self.from_dna(input)
    Nucleotide.new(input)
  end

  def initialize(dna)
    @dna = dna
    raise ArgumentError unless valid_DNA?
  end

  def count(ltr)
    histogram[ltr]
  end

  def histogram
    NUCLEOTIDES.each_with_object({}){|char, o| o[char] = @dna.count(char)}
  end

  def valid_DNA?
    (@dna.chars.uniq - NUCLEOTIDES).empty?
  end

end
