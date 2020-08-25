class MaxIntSet
attr_reader :store

  def initialize(max)
    @store = Array.new(max) {|idx| false}
  end

  def insert(num)
    if is_valid?(num)
      @store[num] = true
    else
      raise "Out of bounds"
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    return false if num > @store.length || num < 0

    true
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num if !self.include?(num)
  end

  def remove(num)
    self[num].reject! {|el| el == num}
  end

  def include?(num)
      self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self.include?(num)
      self[num] << num
      @count += 1
    end

    resize! if @count > num_buckets
  end

  def remove(num)
    start_size = self[num].length
    self[num].reject! {|el| el == num}
    @count -= 1 if start_size != self[num].length
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store
    @count = 0
    @store = Array.new(2*num_buckets) {Array.new}   

    old_store.flatten.each {|num| self.insert(num)}
  end
end
