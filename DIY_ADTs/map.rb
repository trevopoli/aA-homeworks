class Map
    def initialize
        @map = []
    end

    def set(key, value)
        @map.each do |pair|
            pair[1] = value if key == pair[0]
        end
        @map << [key, value] if get(key) == nil
    end

    def get(key)
        @map.each do |pair|
            return pair[1] if key == pair[0]
        end
        nil
    end

    def delete(key)
        @map.each_with_index do |pair, index|
            @map.delete(pair) if pair[0] == key
        end
    end

    def show
        #not sure what supposed to be
    end
end

# my_map = Map.new
# my_map.set("dog", "Sallie")
# my_map.set("cat", "Veronica")
# p my_map
# p my_map.get("dog")
# my_map.set("dog", "Opal")
# my_map.delete("cat")
# p my_map

