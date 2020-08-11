require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        @rows.each do |row|
            puts row.join(" ")
        end
    end
end