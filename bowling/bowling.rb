# record a bowling game scorecard correctly
class Game
  class BowlingError < StandardError
  end
  RULES =
    {
      frames_per_game: 10,
      pins_per_frame: 10,
      rolls_per_frame: 2,
      rolls_per_special_frame: 3
    }.freeze

  ERRORS =
    {
      rolling:
            {
              rule1: proc do |pins, _|
                unless (0..RULES[:pins_per_frame]).cover?(pins)
                  raise BowlingError, 'Must roll between 0 and 10 pins.'
                end
              end,
              rule2: proc do |_pins, this_game|
                if this_game.send(:game_over?)
                  raise BowlingError, 'Game is already over.'
                end
              end,
              rule3: proc do |pins, active_game|
                if pins > active_game.instance_variable_get(:@pins_left)
                  raise BowlingError, "Cannot roll #{pins} because
                   there are only #{@pins_left} available."
                end
              end
            },
      scoring:
            {
              rule1: proc do |active_game|
                if active_game.instance_variable_get(:@frames).empty?
                  raise BowlingError, 'Unstarted game cannot be scored.'
                end
              end,
              rule2: proc do |active_game|
                unless active_game.send(:game_over?)
                  raise BowlingError, 'Incomplete game cannot be
                  scored.'
                end
              end
            }
    }.freeze

  def initialize
    @frames = { 1 => [] }
    @pins_left = RULES[:pins_per_frame]
    @score = 0
  end

  def roll(pins)
    ERRORS[:rolling].each_key { |i| ERRORS[:rolling][i][pins, self] }

    @pins_left -= pins

    @frames[current_frame] <<= pins

    return unless frame_closed?
    @frames[current_frame + 1] = [] unless special_frame
    reset_frame
  end

  def score
    score_errors
    @frames.keys[0...RULES[:frames_per_game] - 1].each do |frame|
      @score += @frames[frame].reduce(:+)
      score_bonuses(frame)
    end
    @score += @frames[RULES[:frames_per_game]].reduce(:+)
  end

  private

  def reset_frame
    @pins_left = RULES[:pins_per_frame]
  end

  def current_frame
    @frames.keys.last
  end

  def frame_closed?
    if bonus_roll?
      reset_frame if reset_pins_for_bonus_rolls?
      completed_rolls_current_frame == RULES[:rolls_per_special_frame]
    else
      completed_rolls_current_frame == RULES[:rolls_per_frame] ||
        pins_down_in_frame == RULES[:pins_per_frame]
    end
  end

  def strike?(frame = current_frame)
    pins_down_first_roll_of_frame(frame) == RULES[:pins_per_frame]
  end

  def spare?(frame = current_frame)
    !strike?(frame) && pins_down_in_frame(frame) == RULES[:pins_per_frame]
  end

  def bonus_roll?
    return unless special_frame
    strike? || spare?
  end

  def special_frame(frame = current_frame)
    frame == RULES[:frames_per_game]
  end

  def reset_pins_for_bonus_rolls?
    completed_rolls_current_frame == 1 && strike? ||
      (completed_rolls_current_frame == 2 && spare? ||
      pins_down_second_roll_of_frame == RULES[:pins_per_frame])
  end

  def pins_down_first_roll_of_frame(frame = current_frame)
    @frames[frame][0]
  end

  def pins_down_second_roll_of_frame(frame = current_frame)
    @frames[frame][1]
  end

  def pins_down_in_frame(frame = current_frame)
    @frames[frame][0..1].reduce(:+)
  end

  def game_over?
    special_frame(current_frame) && frame_closed?
  end

  def completed_rolls_current_frame
    @frames[current_frame].count
  end

  def index_of_next_roll(frame)
    index = 0
    @frames.keys[0..frame - 1].each do |k|
      index += @frames[k].count
    end
    index
  end

  def score_bonuses(frame)
    all_rolls = @frames.values.flatten
    ndx = index_of_next_roll(frame)
    @score += all_rolls[ndx..ndx + 1].reduce(:+) if strike?(frame)
    @score += all_rolls[ndx] if spare?(frame)
  end

  def score_errors
    ERRORS[:scoring].each_key { |i| ERRORS[:scoring][i][self] }
  end
end

module BookKeeping
  VERSION = 3
end
