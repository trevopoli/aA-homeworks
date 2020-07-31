class PolyTreeNode

    attr_reader :value, :parent
    attr_accessor :children

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if @parent
            @parent.children.delete(self)
        end
        @parent = node
        @parent.children << self if node != nil && !@parent.children.include?(self)
    end

    def add_child(node)
        node.parent = self
    end

    def remove_child(node)
        raise "Not a child" if !@children.include?(node)
        node.parent = nil
        @children.delete(node)
    end

    def dfs(target_value)
        return self if @value == target_value
        @children.each do |child| 
            searched_value = child.dfs(target_value)
            return searched_value unless searched_value.nil?
        end
        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.length <= 0
            current_el = queue.shift
            return current_el if current_el.value == target_value
            queue.push(current_el.children)
        end
        nil
    end
end

n1 = PolyTreeNode.new("root1")
n2 = PolyTreeNode.new("root2")
n3 = PolyTreeNode.new("root3")

# connect n3 to n1
n3.parent = n1
# connect n3 to n2
n3.parent = n2

p n1.children
p n2.children