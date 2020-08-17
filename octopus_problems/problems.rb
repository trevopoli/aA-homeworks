fishes = [
    'fish', 
    'fiiish', 
    'fiiiiish', 
    'fiiiish', 
    'fffish', 
    'ffiiiiisshh', 
    'fsh', 
    'fiiiissshhhhhh'
]

def sluggish_octopus(fishes) # O(n^2)
  fishes.each_with_index do |fish1, i1|
    max_length = true
    
    fishes.each_with_index do |fish2, i2|
      next if i1 == i2
      max_length = false if fish2.length > fish1.length
    end
    
    return fish1 if max_length
  end
end

def dominant_octopus(fishes) # O(nlogn)
    prc = Proc.new { |x, y| y.length <=> x.length }
  
    fishes.merge_sort(&prc)[0]
end

class Array
  #this should look familiar
  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }

    return self if count <= 1

    midpoint = count / 2
    sorted_left = self.take(midpoint).merge_sort(&prc)
    sorted_right = self.drop(midpoint).merge_sort(&prc)

    Array.merge(sorted_left, sorted_right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []

    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged << left.shift
      when 0
        merged << left.shift
      when 1
        merged << right.shift
      end
    end

    merged.concat(left)
    merged.concat(right)

    merged
  end
end

def clever_octopus(fishes) # O(n)
    largest_fish = fishes[0]

    fishes.each do |fish|
        largest_fish = fish if fish.length > largest_fish.length
    end

    largest_fish
end