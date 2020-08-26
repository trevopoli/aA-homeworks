class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !self.include?(key)
      self[key] << key
      @count += 1
    end

    resize! if @count > num_buckets
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    start_size = self[key].length
    self[key].reject! {|el| el == key}
    @count -= 1 if start_size != self[key].length
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
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
