require_relative "poly_tree_node"

class KnightPathFinder

    def self.root_node
        PolyTreeNode.New(@start_pos)
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
        build_move_tree(self.root_node)
        @considered_positions = [@start_pos]
    end

    # def find_path
        
    # end

    def build_move_tree
        
    end

    def new_move_positions(pos)
        new_moves = self.valid_moves(pos).select {|move| !@considered_positions.include?(move)}
        @considered_positions << new_moves
    end

end

p KnightPathFinder.valid_moves([0,0])