require_relative 'piece'

class Board

    def initialize
        @rows = Array.new(8) {Array.new(8)}

        (0..7).each do |row|
            if row == 0 || row == 1 || row == 6 || row == 7
                @rows[row].map! {|peice| Piece.new}
            else
                # @rows[row].map! {|piece| NullPiece.new}
                @rows[row].map! {|piece| nil}
            end
        end
    end

    def [](pos)
        raise 'invalid pos' unless valid_pos?(pos)

        row = pos[0]
        col = pos[1]
        
        @rows[row][col]
    end

    def []=(pos, piece)
        raise 'invalid pos' unless valid_pos?(pos)

        row = pos[0]
        col = pos[1]
        
        @rows[row][col] = piece
    end

    def valid_pos?(pos)
        pos.all? { |i| i.between?(0, 7) }
    end

    def move_piece(start_pos, end_pos)
        raise 'no piece at start_pos' if self.empty?(start_pos)
        raise 'not a valid end_pos' if !self.valid_pos?(end_pos)
        
        self[end_pos] = self[start_pos]
        self[start_pos] = nil
    end

    def empty?(pos)
        !self[pos].is_a?(Piece)
    end

end

board = Board.new
board.move_piece([1,1], [4,4])
p board