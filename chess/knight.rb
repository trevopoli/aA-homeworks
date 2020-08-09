require_relative 'stepable'
require_relative 'piece'

class Knight < Piece
    include Slidable

    def symbol
        "N"
    end

    protected

    def move_diffs
        [[1,2],[2,1],[-1,2][-2,1],[-1,-2],[-2,-1]]
    end

end