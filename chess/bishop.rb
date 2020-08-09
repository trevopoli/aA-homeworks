require_relative 'slidable'
require_relative 'piece'

class Bishop < Piece
    include Slidable

    def symbol
        "B"
    end

    protected

    def move_dirs
        diagonal_dirs
    end

end