hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

#use the each method to output all of the vowels from the strings

VOWELS = 'aeiouAEIOU'

hsh.each do |key, value|
	value.each do |word|
		word.each_char do |char|
			puts char if VOWELS.include?(char)
		end
	end
end