require_relative "poly_tree_node"
require "byebug"

class KnightPathFinder

    def self.root_node(start_pos)
        PolyTreeNode.new(start_pos)
    end

    def self.valid_moves(pos)
        movements = [-2,-1,1,2]
        valid_moves = []
        movements.each do |x|
            new_x = pos[0] + x
            movements.each do |y|
                new_y = pos[1] + y
                valid_moves << [new_x, new_y] if x.abs != y.abs && new_x.between?(0,7) && new_y.between?(0,7)
            end
        end
        valid_moves
    end

    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [@start_pos]
        build_move_tree(KnightPathFinder.root_node(@start_pos))
    end

    # def find_path
        
    # end

    def build_move_tree(root)
        queue = [root]
        until queue.empty?
            pos_node = queue.shift 
            new_move_positions(pos_node.value).each do |new_pos| #added value to get [x,y] from node
                new_pos_node = PolyTreeNode.new(new_pos)
                pos_node.add_child(new_pos_node)
                queue << new_pos_node
            end
        end
    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos)
        non_repeat_new_moves = new_moves.select {|move| !@considered_positions.include?(move)}
        non_repeat_new_moves.each do |ele|
            @considered_positions << ele
        end
        non_repeat_new_moves
    end

end

kpf = KnightPathFinder.new([0,0])