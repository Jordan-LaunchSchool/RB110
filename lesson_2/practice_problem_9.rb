arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

#return a new array of the same structure but with sin arrays being ordered alphabetically or
# numberically as appropriate

new_array = arr.map do |sub_array|
							sub_array.sort do |a, b|
								b <=> a
							end
						end

p new_array