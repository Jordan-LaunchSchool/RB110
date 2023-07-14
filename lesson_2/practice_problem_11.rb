arr = [[2], [3, 5, 7, 12], [9], [11, 13, 15]]

# use the `selec` or `reejct` method to return a new array, identical in structure,
# to the original array but containing only integers that are multiples of 3

new_array = arr.map do |array|
	array.select do |number|
		number % 3 == 0
	end
end

p arr
p new_array