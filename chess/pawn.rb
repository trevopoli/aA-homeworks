require_relative 'piece'

class Pawn < Piece

    def symbol
        "P"
    end

    def move_dirs
        [[1,2],[2,1],[-1,2][-2,1],[-1,-2],[-2,-1]]
    end

    

end