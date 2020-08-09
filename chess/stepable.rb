
module Stepable

    def moves
        moves = []

        move_diffs.each do |step|
            step[0] = dx 
            step[1] = dy

            x, y = pos
            new_pos = [x + dx, y + dy]
            
            if board.valid_pos?(new_pos)
                moves << new_pos if board.empty?(new_pos) || !board.valid_pos?(new_pos)
            end
        end
        
        moves
    end


    def move_diffs
        # subclass overwrites
    end
end