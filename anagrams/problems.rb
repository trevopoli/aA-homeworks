
def first_anagram?(word1, word2)
    word1_array = word1.split("")

    anagrams = word1_array.permutation(word1_array.length).to_a

    anagrams.map! {|word| word.join("")}

    anagrams.any? {|anagram| anagram == word2}
end

def second_anagram?(word1, word2)
    word1_array = word1.split("")
    word2_array = word2.split("")

    word1_array.each do |letter|
        return false if !word2_array.include?(letter)
        matching_letter = word2_array.find_index(letter)
        word2_array.delete_at(matching_letter)
    end

    true if word2_array.empty?
end

def third_anagram?(word1, word2)
    word1.split("").sort == word2.split("").sort
end

def fourth_anagram?(word1, word2)
    word1_hash = Hash.new(0)
    word2_hash = Hash.new(0)

    word1.split("").each do |letter|
        word1_hash[letter] += 1
    end

    word2.split("").each do |letter|
        word2_hash[letter] += 1
    end
    
    word1_hash == word2_hash
end

# p third_anagram?("elvis", "lives")
# p third_anagram?("gizmo", "sally") 