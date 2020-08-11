require_relative 'display'

class Game

    def intialize
        @board = Board.new
        @display = Display.new(@board)
    end

end

game = Game.new