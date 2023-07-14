hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

# write some code that will reuturn an array containing the colours of the fruits
# the sizes of the vegetables
# the sizes should be uppercase and the colours should be capitalized

array = hsh.map do |key, details|
	if details[:type] == 'fruit'
		details[:colors].map {|color| color.capitalize}
	else
		details[:size].upcase
	end
end

p array