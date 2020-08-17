TEST_ARRAY = [1,3,5,7,8,3,1,3,5,2,-6,8,0,2]

def my_min(array)
    min = array[0]

    array.each do |x|
        min = x if x < min
    end    

    min
end

def largest_contiguous_subsum(array)
    largest_subsum = array[0]
    current_sum = array[0]

    (1...array.length).each do |i|
        current_sum = 0 if current_sum < 0
        current_sum += array[i]
        largest_subsum = current_sum if largest_subsum < current_sum
    end

    largest_subsum
end 

# list = [2, 3, -6, 7, -6, 7]
# p largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])