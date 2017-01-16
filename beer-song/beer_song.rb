module BookKeeping
  VERSION = 2
end

class BeerSong
  VERSES = {0 => "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n", 1 => "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n", 2 => "2 bottles of beer on the wall, 2 bottles of beer.\n" \
    "Take one down and pass it around, 1 bottle of beer on the wall.\n"}
  def verse(num)
    unless VERSES[num]
      v = "#{num} bottles of beer on the wall, #{num} bottles of beer.\n" \
              "Take one down and pass it around, #{num-1} bottles of beer on the wall.\n"
      VERSES.merge!(num => v)
    end
    VERSES[num]
  end

  def verses(start, stop)
    song = []
    while start >= stop
      song << self.verse(start)
      start -= 1
    end
    song.join("\n")
  end

  def lyrics
    self.verses(99, 0)
  end
end
