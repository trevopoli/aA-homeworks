require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.over? && @board.won? && @board.winner != evaluator

    if self.next_mover_mark == evaluator
      return true if self.children.all? {|node| node.losing_node?(evaluator)}
    else
      return true if self.children.any? {|node| node.losing_node?(evaluator)}
    end

    false
  end

  def winning_node?(evaluator)
    if board.over?
      return board.winner == evaluator
    end

    if self.next_mover_mark == evaluator
      return true if self.children.any? {|node| node.winning_node?(evaluator)}
    else
      return true if self.children.all? {|node| node.winning_node?(evaluator)}
    end

    false
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row,col]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = @next_mover_mark
          @next_mover_mark == :x ? child_mark = :o : child_mark = :x
          child = TicTacToeNode.new(new_board, child_mark, pos)
          children << child
        end
      end
    end
    children
  end
end
