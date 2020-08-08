
module Slidable
    HORIZONTAL_DIRS: [
        [0,1]
        [1,0]
        [-1,0]
        [0,-1]
    ].freeze

    DIAGONAL_DIRS: [
        [1,1]
        [-1,-1]
        [1,-1]
        [-1,1]
    ].freeze

    def horizontal_dirs
        HORIZONTAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        moves = []

        move_dirs.each do |dx, dy|
            moves.concat(grow_unblocked_moves_in_dir(dx, dy))
        end
        moves
    end

    private

    def move_dirs
        #overwritten is subclass
    end

    def grow_unblocked_moves_in_dir(dx, dy)
        moves = []
        x, y = pos

        loop do
            x, y = x + dx, y + dy

            pos = [x, y]

            break if !board.valid_pos?(pos)

            if board.empty?(pos)
                moves << pos
            elsif board[pos].color != color
                moves << pos # take opposing piece
                break
            else
                break
            end
        end
        moves
    end
end