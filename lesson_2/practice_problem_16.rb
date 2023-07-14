=begin
	- write a method that outputs a UUID with no parameters
	- each UUID consists of 32 hexadecimal characters
	- is broken into 4 secionds 8-4-4-4-12
	- output is a string e.g "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

	ALGO:
	- initialise a constant containing hexidecimal digits
	
	- define the hexidecimal method that takes no parameters
	- create a first section varaible (8)
	
	- create a second section varaible (4)

	- create a third section variable (4)

	- create a fourth section variable (4)

	- create a fifth section variable (12)

	- use string interpolation to output the completed hexi digit


	RANDOM Generator
		- define a method that takes a parameter, which is the amount of characters to generate
		- initialise a result variable assigned to an empty string
		- for parameter times, pull a random character from the hexidecimal array
			- add the character the to result string
		- return the result string
=end

HEXADECIIMAL = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)

def generate_uuid
	"#{hexi_generate(8)}-#{hexi_generate(4)}-#{hexi_generate(4)}-#{hexi_generate(4)}-#{hexi_generate(12)}"
end

def hexi_generate(character_length)
	result_string = ''
	character_length.times do
		result_string << HEXADECIIMAL.sample
	end
	result_string
end

p generate_uuid