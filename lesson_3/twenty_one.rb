# twenty_one.rb

=begin
	1. Initialise deck
	2. Deal cards to player and dealer
	3. Player turn: hit or stay
		- repeat until bust or "stay"
	4. If player busts, dealer wins.
	5. Dealer turn: hit or stay
		- repeat until total >= 17
	6. If dealer busts, player wins.
	7. Compare cards and declare winner


	# 2. Deal cards to player and dealer
	ALGO:
		- create a variable named player cards as an empty array
		- create a variable named dealer cards as an empty array
			- move two cards from deck into player cards (pop?)
			- move two cards from deck into dealer cards

	3. Player turn: hit or stay
		
=end

require 'pry'

SUITS = ['H', 'S', 'D', 'C']
CARDS = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K']

def prompt(msg)
	puts "==> #{msg}"
end

def initialise_deck
	deck = SUITS.each_with_object([]) do |suit, array|
		CARDS.each do |card|
			array << [suit, card]
		end
	end
	deck.shuffle
end

def calculate_total(cards)
	values = cards.map {|card| card.last }
	sum = 0

	values.each do |value|
		if value == 'A'
			sum += 11
		elsif value.to_i == 0
			sum += 10
		else
			sum += value.to_i
		end
	end

	values.select {|value| value == 'A'}.count.times do
		sum -= 10 if sum > 21
	end

	sum
end

def busted?(score)
	score > 21
end

def detect_winner(player_total, dealer_total)
	if player_total > dealer_total && !busted?(player_total)
		"player"
	elsif dealer_total > player_total && !busted?(dealer_total)
		"computer"
	elsif dealer_total == player_total
		"tie"		
	end
end







loop do
	# 1. Initialise deck
	deck = initialise_deck

	# 2. Deal cards to player and dealer
	player_cards = deck.pop(2)
	dealer_cards = deck.pop(2)
	player_total = calculate_total(player_cards)
	dealer_total = calculate_total(dealer_cards)

	# 3. Player turn: hit or stay
	loop do
		system 'clear'
		# 4. If player busts, dealer wins.
		player_total = calculate_total(player_cards)
		if busted?(player_total)
			prompt "You busted with a score of #{player_total}! Your cards: #{player_cards}"
			break
		end

		prompt "The dealer has #{dealer_cards[0]} and an unknown card."
		prompt "You have #{player_cards} and are on a total of #{player_total}."
		prompt "(h)it or (s)tay?"
		answer = gets.chomp.downcase
		break if answer[0] == 's'

		player_cards << deck.pop
		prompt "You drew a #{player_cards.last}"
		prompt "Press any get to continue..."
		gets.chomp
	end

		#5. Dealer turn: hit or stay
		# - repeat until total >= 17
	loop do
		dealer_total = calculate_total(dealer_cards)
		break if busted?(player_total)

		if busted?(dealer_total)
			prompt "The dealer busted with #{dealer_total}."
			prompt "You won!"
			break
		end
		
		system 'clear'

		prompt "The dealer has #{dealer_cards} and is on #{dealer_total}."
		prompt "You are on #{player_total}"

		if dealer_total < 17
			dealer_cards << deck.pop
			prompt "The dealer hits and draws a #{dealer_cards.last}."
			prompt "Press any key to continue..."
			gets
		else
			break
		end

	end


	# 7. Compare cards and declare winner

	winner = detect_winner(player_total, dealer_total)

	if winner == "player"
		prompt "You won with #{player_total}"
		prompt "The dealer finished on #{dealer_total}."
	elsif winner == "computer"
		prompt "The dealer won with #{dealer_total}"
	elsif winner == "tie"
		prompt "It was a tie!"
	end

	prompt "Play again? (y/n)"
	play_again = gets.chomp.downcase[0]
	break if play_again == 'n'
end


prompt "Thanks for playing twenty-one. Goodbye!"

