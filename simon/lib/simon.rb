class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    self.take_turn until @game_over

    if @game_over
      self.game_over_message
      self.reset_game
    end
  end

  def take_turn
    self.show_sequence
    self.require_sequence
    unless @game_over
      self.round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    self.add_random_color
    p @seq
  end

  def require_sequence
    puts "Repeat colors one at a time:"
    (0...@sequence_length).each do |n|
      guessed_color = gets.chomp.downcase
      if @seq[n] != guessed_color
        @game_over = true
        break
      end
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Great! Next Round:"
  end

  def game_over_message
    puts "Incorrect! Game Over."
  end

  def reset_game
    @seq = []
    @sequence_length = 1
    @game_over = false
  end
end

simon = Simon.new

simon.play
