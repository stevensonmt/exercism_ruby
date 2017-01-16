class Crypto

attr_accessor :text, :size

  def initialize(text)
    @text = text
  end

  def normalize_plaintext
    text.downcase.split(/\W/).join
  end

  def plaintext_segments
    normalize_plaintext.chars.each_slice(size).map(&:join)
  end

  def size
    columns
  end

  def ciphertext
    ciphertext = ""
    (0..size).each do |i|
      plaintext_segments.each do |seg|
        if seg.chars[i]
          ciphertext += seg.chars[i]
        next
        end
      end
    end
    ciphertext
  end

  def normalize_ciphertext
    p ciphertext.chars.each_slice(size-1).map(&:join).join(" ")
  end

  private

  def columns
    Math.sqrt(normalize_plaintext.length).round == Math.sqrt(text.length) ? Math.sqrt(normalize_plaintext.length) : (Math.sqrt(normalize_plaintext.length) + 0.5).round
  end

  def rows
    columns == Math.sqrt(normalize_plaintext.length) ? columns : columns - 1
  end

  def empty_spaces
    return if normalize_plaintext.length == columns * rows
    normalize_plaintext % columns
  end

end
# p Math.sqrt(Crypto.new('Oh hey, this is nuts!').normalize_plaintext.length).to_s.split(".").first.to_i
