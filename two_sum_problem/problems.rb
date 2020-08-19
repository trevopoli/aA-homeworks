def bad_two_sum?(arr, target) # O(n2)

    (0...arr.length).each do |i|
        (i+1...arr.length).each do |j|
            return true if arr[i] + arr[j] == target
        end
    end

    false
end

def okay_two_sum?(arr, target) # O(nlogn)
    sorted_arr = arr.sort

    sorted_arr.each_with_index do |ele, idx|
        matching_idx = sorted_arr.bsearch_index {|ele2| (target - ele) <=> ele2}
        return true if matching_idx && matching_idx != idx
    end
    false
end

def two_sum?(arr, target) #O(n)
    hash = {}
    arr.each do |ele|
        return true if hash[target - ele]
        hash[ele] = true
    end

    false
end

# arr = [0, 1, 5, 7]
# p two_sum?(arr, 6) # => should be true
# p two_sum?(arr, 10) # => should be false