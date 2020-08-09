
module Stepable

    def moves
        moves = []

        move_diffs.each do |step|
            dx = step[0]
            dy = step[1]
            p moves
            p pos
            x, y = pos
            new_pos = [x + dx, y + dy]
            
            if board.valid_pos?(new_pos)
                moves << new_pos if board.empty?(new_pos) || board[new_pos].color != color
            end
        end
        
        moves
    end

    def move_diffs
        # subclass overwrites
    end
end