require_relative 'slidable'
require_relative 'piece'

class Rook < Piece
    include Slidable

    def symbol
        "R"
    end

    protected

    def move_dirs
        horizontal_dirs
    end

end