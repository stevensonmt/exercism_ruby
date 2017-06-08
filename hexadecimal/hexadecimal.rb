class Hexadecimal

  CONVERSION_TABLE = (("0".."9").to_a + ("a".."f").to_a).zip((0..15).to_a).to_h

  def initialize(str)
    @hex = str.downcase.reverse.chars
  end

  def to_decimal
    if valid_hex?
      get_exponents_as_hash.sum{|k,v| v*16**k}
    else
      0
    end
  end

  def valid_hex?
    @hex.all?{|i| i.match(/\d|[a-f]/)}
  end

  def get_exponents_as_hash
    @hex.each_with_index.with_object({}){|en, h| h[en[1]] = hex_to_i(en[0])}
  end

  def hex_to_i(str)
    CONVERSION_TABLE[str]
  end

end
