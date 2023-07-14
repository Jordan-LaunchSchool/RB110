arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

# write a program that will return a hash where the key of the first item
# in each sub array and the value is the second item

new_hash = arr.each_with_object({}) do |sub_array, hash|
	hash[sub_array[0]] = sub_array[1]
end

p new_hash
