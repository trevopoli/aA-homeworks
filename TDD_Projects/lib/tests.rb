
def my_uniq(array)
    uniq_elements = []
    array.each do |ele|
        uniq_elements << ele unless uniq_elements.include?(ele)
    end

    uniq_elements
end

class Array

    def two_sum
        pairs = []
        (0...self.length).each do |i|
            (i+1...self.length).each do |j| #keep direction-wise and don't repeat
                pairs << [i, j] if self[i] + self[j] == 0
            end
        end
        pairs
    end


end

def my_transpose(array)
    raise ArgumentError.new 'Not a square matrix' unless array.all? {|el| el.length == array.length}

    transposed = []
    (0...array.length).each do |i|
        col = []
        array.each do |row|
            col << row[i]
        end
        transposed << col
    end
    transposed
end

def stock_picker(stock_array)
    highest_profit = 0
    highest_pair = []

    (0...stock_array.length).each do |day|
        (day+1...stock_array.length).each do |future_day|
            profit = stock_array[future_day] - stock_array[day]
            if profit > highest_profit
                highest_profit = profit
                highest_pair = [day, future_day]
            end
        end
    end

    highest_pair
end

class TowersOfHanoi
attr_accessor :left, :right, :middle

    def initialize 
        @left = [1,2,3,4,5]
        @middle = []
        @right = []
    end

    def move(start, ending)
        case start
        when 1
            block = @left.shift
        when 2 
            block = @middle.shift
        when 3
            block = @right.shift
        else
            raise ArgumentError 'not a valid staring point'
        end

        case ending
        when 1
            end_array = @left
        when 2 
            end_array = @middle
        when 3
            end_array = @right
        else
            raise 'not a valid ending point'
        end

        if end_array.empty? || end_array[0] > block
            end_array.unshift(block)
        else
            raise 'not a valid move' 
        end
        
    end

    def start
        until self.won? do
            self.render
            self.get_move
        end
        puts 'Completed!'
    end

    def get_move
        puts 'Enter move ex. 1,3:'
        move = gets.chomp.split(',')
        self.move(move[0].to_i, move[1].to_i)
    end

    def render
        (0..4).each do |i|
            if @left[i]
                print @left[i]
            else
                print " "
            end
            if @middle[i]
                print @middle[i]
            else
                print " "
            end
            if @right[i]
                print @right[i]
            else
                print " "
            end
            puts ""
        end
    end

    def won?
        @right == [1,2,3,4,5]
    end

end

# game = TowersOfHanoi.new
# game.start