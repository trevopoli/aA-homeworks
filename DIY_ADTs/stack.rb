class Stack
    def initialize
        @stack = []
    end

    def push(el)
      @stack.push(el)
    end

    def pop
      @stack.pop
    end

    def peek
      @stack[-1]
    end
end

# stack = Stack.new
# stack.push("cool")
# stack.push("stuff")
# p stack.peek
# p stack