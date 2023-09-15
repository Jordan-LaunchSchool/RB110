# twenty_one_v2.rb

=begin

1. Initialize deck
2. Deal cards to player and dealer
3. Player turn: hit or stay
  - repeat until bust or "stay"
4. If player bust, dealer wins.
5. Dealer turn: hit or stay
  - repeat until total >= 17
6. If dealer bust, player wins.
7. Compare cards and declare winner.

ALGO:
Methods:
  Prompt method
	- takes a string and outputs it with a prompt

	calculate total method:
  e.g [['S', 'A'], ['S', 'K'], ['S', 'J'] - 21 or 31?
	- have the method take the dealer or player cards as an argument
	- create a values array and assign it to all of the values of the cards
	- create a sum variable assigned to 0
	- iterate over the values array
		- if the current iteration is an ace
			- add 11 to the sum
		- if J - K
			- add 10 to the sum
		- otherwise, add the current iteration, converted to an integer
		to the sum.

		if the sum is over 21
			- iterate over the values, count how many aces.
				- start a loop that iterates for the amount of aces there are
				that subtracts 10 from the sum

	busted?
			- define a method that takes the score of the player or dealer
			- if the score is greater than 21, return true

	play_again?
		- define a method
		- ask the player if they would like to play again?
		- get the players answer
		- if the players input is equal to 'y' then return true

	display_result
	- write a method that takes the player and dealer scores
	- consider the return value of the #detect result method
	- output a string depending on the result

	detect_result
			- write a method that takes the player and dealer scores
			- return a symbol depending on the following condtions:
				- player busted
				- dealer busted
				- player wins
				- dealer wins
				- tie

Intialise deck
	- create a suits CONSTANT array with the different suits
	- create a card CONSTANT value array with cards 2 - K
	- define a initialise deck method 
		- have the method combine the suits and adds them to a deck of cards variable
		- have the method return the deck of cards shuffled
	- assign the return value of the initialise deck to a shuffled_deck variable

Deal cards to player and dealer
	- create a variable named players cards, assign an empty array
	- create a varaibled named dealers cards, assign an empty array
	- give the dealer and the player 2 cards by running a loop twice and
	removing two cards from the deck array and adding to the player/dealer's array

Player turn: hit or stay
	- begin a loop
	- clear the system terminal
	- calculate and assign player score
	- show the dealers first card and a ? card
	- show the all of the players cards and the total score they are on

	- begin a loop
		- ask the player if the would like to hit or stay?
			- if the player selects hit
				- remove a card from the deck and add it to the players card array
			- if the player selects stay || player has busted?
				- break out of the loop
	- end loop

	- if player has busted?
		-	display result
		- ask the player if the would like to play again?
			if yes, next otherwise break
			
	Dealer Turn:
	- begin a loop
	- Show the dealers cards and score

	- if the dealer busted?
		- play again? next : break
		
	- if the dealer is < 17
		- prompt the dealer hits
		- remove a card from the deck and add it to the dealers array
		- recalculate dealers score
		- prompt, press any key to continue...
	- if the dealer is >= 17
		- break out of the loop
	- end loop
	
Compare cards and declare winner
		- system clear
		- display the players cards and score
		- display the dealers cards and score
		- #display_result
		- break if play again? == false

=end

# intialise deck
SUITS = ['S', 'C', 'D', 'H']
NUMBER_CARDS = ('2'..'10').to_a
PICTURE_CARDS = ['J', 'Q', 'K', 'A']

def intialise_deck
	SUITS.product(NUMBER_CARDS + PICTURE_CARDS).shuffle
end

def prompt(msg)
	puts "==> #{msg}"
end

def calculate_score(cards)
	values = cards.map { |card| card.last }
	sum = 0

	values.each do |value|
		if value == 'A'
			sum += 11			
		elsif PICTURE_CARDS.include?(value)
			sum += 10
		else
			sum += value.to_i
		end
	end
	
	if sum > 21
		values.count('A').times do
	 		sum -= 10
		end
	end

	sum
end

def busted?(score)
	score > 21
end

def detect_result(player_score, dealer_score)
	if player_score > 21
		:player_busted
	elsif dealer_score > 21
		:dealer_busted
	elsif dealer_score > player_score
		:dealer_wins
	elsif dealer_score < player_score
		:player_wins
	else
		:tie
	end
end

def display_result(player_cards, dealer_cards, player_score, dealer_score)
	result = detect_result(player_score, dealer_score)
	case result
	when :player_busted
		prompt "You busted! You finished on #{player_score}."
		prompt "The dealer had #{dealer_cards} and a score of #{dealer_score}."
	when :dealer_busted
		prompt "The dealer busted! The dealer busted with a score #{dealer_score} and had #{dealer_cards}"
	when :dealer_wins
		prompt "The dealer wins with #{dealer_cards} and a score of #{dealer_score}."
		prompt "You finished with #{player_cards} and #{player_score}."
	when :player_wins
		prompt "You won! Your total is #{player_score}."
		prompt "The dealer had ##{dealer_cards} and finished on #{dealer_score}."
	when :tie
		prompt "It's a tie!"
	end
end

def play_again?
	loop do
		prompt "Would you like to play again? (y/n)"
		player_answer = gets.chomp.downcase[0]
		if player_answer == 'y'
			return true
		elsif player_answer == 'n'
			return false
		else
			prompt "That is not a valid answer."
		end
	end
end

loop do

	deck_of_cards = intialise_deck

	#deal cards to player and dealer
	player_cards = []
	dealer_cards = []

	2.times do
		player_cards << deck_of_cards.pop
		dealer_cards << deck_of_cards.pop
	end

	player_score = calculate_score(player_cards)
	dealer_score = calculate_score(dealer_cards)

	# player turn: hit or stay?
	loop do
		system 'clear'
		prompt "The dealer has #{dealer_cards[0]} and ?."
		prompt "You have #{player_cards} and are on #{player_score}"

		
		break if busted?(player_score)

		prompt "Would you like to (h)it or (s)tay?"
		player_turn = gets.chomp.downcase[0]
		
		if player_turn == 'h'
			player_cards << deck_of_cards.pop
			player_score = calculate_score(player_cards)
			next
		elsif player_turn == 's'
			break
		else
			prompt "That is not a valid choice."
			prompt "Press any key to continue..."
			gets
		end
	end

	if busted?(player_score)
		system 'clear'
		display_result(player_cards, dealer_cards, player_score, dealer_score)
		play_again? ? next : break
	end

	# dealer turn
	loop do
		system 'clear'
		prompt "The dealer has #{dealer_cards} and is on #{dealer_score}."
		prompt "You have #{player_cards} and are on #{player_score}"

		if busted?(dealer_score)
			system 'clear'
			display_result(player_cards, dealer_cards, player_score, dealer_score)
			play_again? ? next : break
		elsif dealer_score < 17
			dealer_cards << deck_of_cards.pop
			dealer_score = calculate_score(dealer_cards)
			prompt "The dealer hits and receives #{dealer_cards.last}"
			prompt "Press any key to continue..."
			gets
		else
			break
		end
	end

	system 'clear'
	display_result(player_cards, dealer_cards, player_score, dealer_score)
	play_again? ? next : break
end

prompt "Thank you for playing twenty-one! Goodbye!"
