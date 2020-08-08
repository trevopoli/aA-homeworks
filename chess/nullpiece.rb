require 'singleton'
require_relative 'piece'

class NullPiece < Piece
    include Singleton

    attr_reader :symbol

    def initialize
        @symbol = " "
        @color = nil
    end

    def empty?
        true
    end

    def moves
        []
    end

end