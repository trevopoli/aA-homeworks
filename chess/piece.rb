class Piece

    attr_accessor :pos
    attr_reader :color, :board

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def empty?
        false
    end

    def to_s
        "#{symbol}"
    end

    def symbol
        #subclass overwrites
    end

    def valid_moves
        # moves.reject { |end_pos| move_into_check?(end_pos) }
    end

    private

    def move_into_check?(end_pos)

    end


end