class StaticArray
  attr_reader :store

  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    self.store[i]
  end

  def []=(i, val)
    validate!(i)
    self.store[i] = val
  end

  def length
    self.store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, self.store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_accessor :count, :store

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    if i >= self.count
      return nil
    elsif i < 0
      return nil if i < -self.count
      return self[self.count + i]
    end

    @store[i % capacity]
  end

  def []=(i, val)
    if i >= self.count
      (i - self.count).times { push(nil) }
    elsif i < 0
      return nil if i < -self.count
      return self[self.count + i] = val
    end

    if i == self.count
      resize! if capacity == self.count
      self.count += 1
    end

    self.store[i % capacity] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
    (0...self.capacity).each do |i|
      return true if @store[i] == val
    end
    false
  end

  def push(val)
    resize! if @count == self.capacity

    @store[count] = val
    @count += 1
  end

  def unshift(val)
    resize! if @count == self.capacity

    (@count-1..0).each do |i|
      p @store
      @store[i+1] = @store[i]
    end

    @store[0] = val

    @count += 1 if val

    @store
  end

  def pop
    return nil if @count <= 0

    el = @store[count-1]
    @store[count-1] = nil
    @count -= 1
    el
  end

  def shift
    item = @store[0]

    if @count > 0
      (0...@count-1).each do |i|
        @store[i] = @store[i+1]
      end

      @store[@count-1] = nil
    end
    
    @count -= 1 if item

    item
  end

  def first
    @store[0]
  end

  def last
    @store[count-1]
  end

  def each
    (0...@count).each do |i|
      yield @store[i]
    end
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    return false unless @store.length == other.length
    other.each_with_index { |el, i| return false unless el == @store[i] }
    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    old_store = @store
    old_count = @count
    @count = 0
    @store = StaticArray.new(2 * self.capacity)

    (0...old_count).each do |i|
      self.push(old_store[i])
    end
  end
end
