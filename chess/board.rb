require_relative 'piece'

class Board

    def initialize
        @rows = Array.new(8) {Array.new(8)}

        (0..7).each do |row|
            if row == 0 || row == 1 || row == 6 || row == 7
                @rows[row].map! {|peice| Piece.new}
            else
                @rows[row].map! {|peice| NullPiece.new}
            end
        end
    end

    def [](pos)
        raise 'invalid pos' unless valid_pos?(pos)

        row, col = pos
        @rows[row][col]
    end

    def valid_pos?(pos)

    end

    def move_piece(start_pos, end_pos)
        
    end

end

p rows = rows.new