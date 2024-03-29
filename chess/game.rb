require_relative 'display'
require_relative 'human_player'
require_relative 'board'

class Game
    attr_reader :board, :display, :current_player, :players

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = {
            white: HumanPlayer.new(:white, @display),
            black: HumanPlayer.new(:black, @display)
        }
        @current_player = :white
    end

    def play
        until @board.checkmate?(@current_player)
            begin
                start_pos, end_pos = players[@current_player].make_move(@board)
                @board.move_piece(@current_player, start_pos, end_pos)

                swap_turn!
                notify_players
            rescue StandardError => e
                @display.notifications[:error] = e.message
                retry
            end
        end

        display.render
        puts "#{@current_player} is checkmated."

        nil
    end

    private

    def notify_players
        puts "You are in check" if @board.in_check?(current_player)
    end

    def swap_turn!  
        @current_player = current_player == :white ? :black : :white
    end
end

if __FILE__ == $PROGRAM_NAME
    Game.new.play
end