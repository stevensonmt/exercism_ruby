class Game
  class BowlingError < StandardError
  end
  def initialize
    @all_rolls = []
    @frames = Hash.new { [] }
    @rolls = 0
    @current_frame = 1
    @score = 0
    reset_frame
    @max_rolls_per_frame = 2
    @closed_frames = []
    @lane_pins = 10
  end

  def roll(pins)
    raise BowlingError, 'Must roll between 0 and #{@lane_pins} pins.' unless (0..@lane_pins).cover?(pins)
    raise BowlingError, 'Game is already over.' if game_over?
    raise BowlingError, "Cannot roll #{pins} because there are only #{@pins} available." if pins > @remaining_pins
    @remaining_pins -= pins
    @all_rolls << pins
    @frames[@current_frame] <<= pins
    @rolls += 1
    if bonus_roll?
      @max_rolls_per_frame = 3
      if @frames[@current_frame].reduce(&:+) == @lane_pins || @frames[@current_frame][1] == @lane_pins
        reset_frame
      end
      close_frame
    end
    if frame_closed?
      @closed_frames << @current_frame
      @current_frame += 1 unless bonus_roll?
      @rolls = 0
      reset_frame
    end
  end

  def close_frame
    frame_closed? &&
      @closed_frames << @current_frame
  end

  def reset_frame
    @remaining_pins = 10
  end

  def frame_closed?
    @rolls == @max_rolls_per_frame || @remaining_pins == 0
  end

  def bonus_roll?
    case @current_frame
    when 10
      @frames[@current_frame].reduce(&:+) == @lane_pins || @frames[@current_frame][0] == @lane_pins
    end
  end

  def game_over?
    @closed_frames.length >= 10
  end

  def strike?(rolls)
    rolls[0] == @lane_pins
  end

  def spare?(rolls)
    rolls[0] != @lane_pins && rolls.reduce(&:+) == @lane_pins
  end

  def index_of_next_roll(frame)
    index = 0
    @frames.keys[0..frame - 1].each do |k|
      index += @frames[k].count
    end
    index
  end
  
  def score
    raise BowlingError, "Unstarted game cannot be scored." if @frames.empty?
    raise BowlingError, "Incomplete game cannot be scored." unless game_over?
   scored = 0
    @frames.each_value.reduce(:+) do |rolls|
      ndx = index_of_next_roll(frame)
      # p ndx
      scored += (rolls.reduce(:+))
      if strike?(rolls)
        scored += @all_rolls[ndx..ndx + 1].reduce(&:+) unless frame == 10
      elsif spare?(rolls)
        scored += if frame == 10
                   @all_roll[last]
                 else
                   @all_rolls[ndx]
                 end
      end
    end
    score
  end
end
module BookKeeping
  VERSION = 3
end
