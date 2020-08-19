
def naive_windowed_max_range(arr, window_size)
    current_max_range = 0

    (0..arr.length-window_size).each do |i|
        window = arr[i...i+window_size]
        new_max_range = window.max - window.min
        current_max_range = new_max_range if new_max_range > current_max_range
    end

    current_max_range
end


p naive_windowed_max_range([1, 0, 2, 5, 4, 8], 2) # == 4 # 4, 8
p naive_windowed_max_range([1, 0, 2, 5, 4, 8], 3) # == 5 # 0, 2, 5
p naive_windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p naive_windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8