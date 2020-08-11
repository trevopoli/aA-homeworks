require_relative 'pawn'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'nullpiece'
require_relative 'queen'
require_relative 'rook'

class Board

    def initialize
        @rows = Array.new(8) {Array.new(8)}

        self.fill_start_board
    end

    def fill_start_board
        (0..7).each do |row|
            if row == 0
                row_color = :black
                (0..7).each do |col|
                    pos = [row, col]
                    self.fill_first_row(pos, row_color)
                end
            elsif row == 1
                row_color = :black
                (0..7).each do |col|
                    pos = [row, col]
                    self[pos] = Pawn.new(row_color, self, pos)
                end
            elsif row == 6
                row_color = :white
                (0..7).each do |col|
                    pos = [row, col]
                    self[pos] = Pawn.new(row_color, self, pos)
                end
            elsif row == 7
                row_color = :white
                (0..7).each do |col|
                    pos = [row, col]
                    self.fill_first_row(pos, row_color)
                end
            else
                @rows[row].map! {|p| NullPiece.instance}
            end
        end
    end

    def fill_first_row(pos, color)
        col = pos[1]

        if col == 0 || col == 7
            self[pos] = Rook.new(color, self, pos)
        elsif col == 1 || col == 6
            self[pos] = Knight.new(color, self, pos)
        elsif col == 2 || col == 5
            self[pos] = Bishop.new(color, self, pos)
        elsif col == 3 
            self[pos] = Queen.new(color, self, pos)
        elsif col == 4
            self[pos] = King.new(color, self, pos)
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

        
        if self[start_pos].moves.include?(end_pos) # make sure move is within Piece's valid moves
            self[end_pos] = self[start_pos]
            self[end_pos].pos = end_pos
            self[start_pos] = NullPiece.instance
        else
            raise 'not a possible move'
        end
    end

    def empty?(pos)
        self[pos].empty?
    end

    def find_king(color)
        king = pieces.find { |p| p.color == color && p.is_a?(King) }
        king || (raise 'no king found')
    end

    def in_check?(color)
        king_piece = find_king(color)
        pieces.any? do |p|
            p.color != color && p.moves.include?(king_piece.pos)
        end
    end

    def checkmate?(color)
        return false unless self.in_check?(color)

        other_pieces = pieces.select { |p| p.color == color }
        other_pieces.all? do |piece|
            piece.valid_moves.empty?
        end
    end

    def pieces
        @rows.flatten.reject(&:empty?)
    end

    def render_help
        @rows.each do |row|
            puts row.join(" ")
        end
    end
end

# board = Board.new

# board.move_piece([6,5], [5,5])
# board.move_piece([1,4], [3,4])
# board.render_help
# board.move_piece([6,6], [4,6])
# board.render_help
# board.move_piece([0,3], [4,7])
# board.render_help
# p board.in_check?(:white)
