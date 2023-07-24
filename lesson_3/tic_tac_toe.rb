=begin

Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn
and marks a square on the board. First player to reach 3 squares in a row,
including diagonals, wins. If all 9 squares are marked and no player has 3
squares in a row, then the game is a tie.

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!

=end

require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
								[[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
								[[1, 5, 9], [3, 5, 7]]

def prompt(msg)
	puts "=> #{msg}"
end

def joinor(arr, delimeter=', ', word='or')
	case arr.size
	when 1 then arr.first
	when 2 then arr.join(" #{word} ")
	else
		arr[-1] = "#{word} #{arr.last}"
		arr.join(delimeter)
	end
end

def display_board(brd)
	system 'clear'
	puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}."
	puts ""
	puts "     |     |"
	puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
	puts "     |     |"
	puts "-----+-----+-----"
	puts "     |     |"
	puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}" 
	puts "     |     |"
	puts "-----+-----+-----"
	puts "     |     |"
	puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}" 
	puts "     |     |"
	puts ""
end

def initialise_board
	new_board = {}
	(1..9).each {|num| new_board[num] = INITIAL_MARKER}
	new_board
end

def empty_squares(brd)
	brd.keys.select {|num| brd[num] == INITIAL_MARKER}
end

def player_places_piece_on_board!(brd)
	square = ''
	loop do
		prompt "Choose a square (#{joinor(empty_squares(brd))})"
		square = gets.chomp.to_i
		
		break if empty_squares(brd).include?(square)
		prompt "Sorry, that's not a valid choice."
	end

	brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
	square = nil

	
	WINNING_LINES.each do |line|
		square = find_at_risk_square(line, brd, COMPUTER_MARKER)
		break if square
	end

		
	if !square
		WINNING_LINES.each do |line|
			square = find_at_risk_square(line, brd, PLAYER_MARKER)
			break if square
		end
	end

	if brd[5] == INITIAL_MARKER
		square = 5
	end

	if !square
		square = empty_squares(brd).sample
	end

	brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
	empty_squares(brd).empty?
end

def someone_won?(brd)
	!!detect_winner(brd)
end

def detect_winner(brd)
	WINNING_LINES.each do |line|
		if brd.values_at(*line).count(PLAYER_MARKER) == 3
			return 'Player'
		elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
			return 'Computer'
		end
	end

	nil
end

def find_at_risk_square(line, brd, marker)
	if brd.values_at(*line).count(marker) == 2
		brd.select{ |k, v| line.include?(k) && v == INITIAL_MARKER}.keys.first
	else
		nil
	end
end


loop do
	computer_score = 0
	player_score = 0
	loop do

		board = initialise_board

		loop do
			#1. Display the initial empty 3x3 board.
			display_board(board)

			#2. Ask the user to mark a square.
			player_places_piece_on_board!(board)
			display_board(board)
			break if someone_won?(board) || board_full?(board)
			
			#3. Computer marks a square.
			computer_places_piece!(board)
			display_board(board)
			break if someone_won?(board) || board_full?(board)
		end

		if someone_won?(board)
			prompt "#{detect_winner(board)} won!"
			computer_score += 1 if detect_winner(board) == 'Computer'
			player_score += 1 if detect_winner(board) == 'Player'
		else
			prompt "It's a tie!"
		end

		if player_score == 5
			prompt "Player is first to 5 wins!"
			break
		elsif computer_score == 5
			prompt "Computer is the first to 5 wins!"
			break
		end

		prompt "You are on a score of #{player_score}."
		prompt "The computer is on #{computer_score}"

		prompt "Press any key to continue to the next round... "
		gets

	end

	

	prompt "Play again? (y or n)"
	answer = gets.chomp
	break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
