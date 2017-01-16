module BookKeeping
  VERSION = 4
end

class Complement
  def self.of_dna(dna)
    dna_to_rna = { 'G' => 'C', 'C' => 'G', 'T' => 'A', 'A' => 'U'}
    dna = dna.upcase
    if dna.count('ACGT')==dna.length
      dna.chars.map do |base|
        dna_to_rna[base]
      end.join
    else
      return ""
    end
  end
end
