array = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# use the map method to return a new array identical in structure
# but where the value of each integer is incremented by 1

new_array = array.map do |hash|
	incremented_hash = {}
	hash.each do |key, value|
		incremented_hash[key] = value + 1
	end
	incremented_hash
end

p array
p new_array
