class Board
  attr_accessor :cups
  attr_reader :name1, :name2

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14)
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0..13).each do |x|
      if x == 6 || x == 13
        @cups[x] = []
      else
        @cups[x] = Array.new(4) {:stone}
      end
    end
  end

  def valid_move?(start_pos)
    if start_pos == 6 || start_pos < 0 || start_pos > 12
      raise ArgumentError.new "Invalid starting cup" 
    end

    raise ArgumentError.new "Starting cup is empty" if @cups[start_pos].length <= 0
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []
    i = 1
    until stones.empty? do
      next_cup = (start_pos + i) % 14 
      if current_player_name == @name1
        @cups[next_cup] << stones.shift if next_cup != 13
      else
        @cups[next_cup] << stones.shift if next_cup != 6
      end   
      i += 1
    end
    self.render
    self.next_turn(next_cup)
    
    case next_cup
    when 6
      return :prompt if current_player_name == @name1
    when 13
      return :prompt if current_player_name == @name2
    end

    return :switch if @cups[next_cup].length == 1 # ended on empty cup

    next_cup
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0..5).each.all? {|cup| @cups[cup].empty?} || (7..12).each.all? {|cup| @cups[cup].empty?}
  end

  def winner
    case @cups[6].count <=> @cups[13].count
    when -1
      @name2
    when 0
      :draw
    when 1
      @name1
    end
  end
end

# board = Board.new('name1', 'name2')
# p board.cups