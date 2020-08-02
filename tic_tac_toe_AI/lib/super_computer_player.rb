require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    node_children = node.children

    node_children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    #no_winning_moves
    node_children.each do |child|
      return child.prev_move_pos if !child.losing_node?(mark)
    end

    raise "No winning or tying move"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
