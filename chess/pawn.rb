require_relative 'piece'

class Pawn < Piece

    def symbol
        "P"
    end

    def moves
        forward_steps + side_attacks
    end

    private

    def at_start_row?
        row = pos[0]

        return true if color == :black && row == 1
        return true if color == :white && row == 6

        false
    end

    def forward_dir
        case color
        when :black
            1
        when :white
            -1
        end
    end

    def forward_steps
        forward_steps = []
        x, y = pos

        one_step = [x + forward_dir, y]
        forward_steps << one_step if board.valid_pos?(one_step) && board.empty?(one_step)

        if at_start_row? && forward_steps.length > 0
            two_step = [x + forward_dir * 2, y]
            forward_steps << two_step if board.empty?(two_step)
        end

        forward_steps
    end

    def side_attacks
        x,y = pos
        side_steps = [[x + forward_dir, y + 1], [x + forward_dir, y - 1]]
        p side_steps

        side_steps.select! do |attack_pos|
            false unless board.valid_pos?(attack_pos)

            board[attack_pos].color != color && !board.empty?(attack_pos)
        end

        p side_steps
        side_steps
    end

end