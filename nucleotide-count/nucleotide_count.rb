class Nucleotide

  NUCLEOTIDES = ["A", "G", "C", "T"]
  attr_reader :histogram

  def self.from_dna(input)
    raise ArgumentError unless valid_dna?(input)
    new(input)
  end

  def initialize(dna)
    @histogram =  NUCLEOTIDES.each_with_object({}) do |nuc, hist|
                    hist[nuc] = dna.count(nuc)
                  end
  end

  def count(ltr)
    histogram[ltr]
  end

  def self.valid_dna?(dna)
    dna.chars.none? {|ltr| !NUCLEOTIDES.include?(ltr) }
  end

end
