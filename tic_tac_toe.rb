class TicTacToe

	POSSIBLE_VICTORIES = [
		['p1', 'p2', 'p3'], ['p4', 'p5', 'p6'], ['p7', 'p8', 'p9'], #rows
		['p1', 'p4', 'p7'], ['p2', 'p5', 'p8'], ['p3', 'p6', 'p9'],	#columns
		['p1', 'p5', 'p9'], ['p3', 'p4', 'p7']						#diagonals
	]

	PLAYERS = {'Player#1' => 'x', 'Player#2' => 'o'}

	attr_accessor :game_board, :active_player_key

	def initialize
		render_game_board
		@active_player_key = PLAYERS.keys.first
		play
	end

	def play
		introduce_game
		show_game_board
		start_game_turns
		show_final_result
	end

	private

		def render_game_board
			@game_board = {}
			(1..9).each { |i| @game_board["p#{i}"] = "p#{i}" }
		end

		def introduce_game			
			puts 'Hello! Welcome to tic-tac-toe :)'
			puts '--------------------------------'
		end

		def show_game_board
			(0..2).each do |i| 
				puts "#{@game_board["p#{1+3*i}"]} | #{@game_board["p#{2+3*i}"]} | #{@game_board["p#{3+3*i}"]}" 
				puts '------------'
			end
		end

		def start_game_turns
			until(game_over? || won_game?)
				puts "#{@active_player_key} enter a valid position:"
				position_input = gets.chomp
				mark_position(position_input)
				toogle_player_turn
				show_game_board
				puts '--------------------------------'
			end
		end

		def show_final_result
			toogle_player_turn # revokes to the last player
			victory_message = "Congrats #{@active_player_key} you WON!! =D"
			game_over_message = 'Game Over! Play again. =('
			puts if won_game? then victory_message else game_over_message 	
		end

		def mark_position(position)
			@game_board[position] = PLAYERS[@active_player_key] if valid_position?(position)
		end

		def valid_position?(position)
			@game_board.has_key?(position) && !already_filled(position)
		end

		def already_filled(position)
			PLAYERS.values.include?(@game_board[position])
		end

		def toogle_player_turn
			@active_player_key = if @active_player_key == 'Player#1' then 'Player#2' else 'Player#1'
		end

		def game_over?
			filled_positions.length == @game_board.length
		end

		def won_game?
			POSSIBLE_VICTORIES.map do |possible_victory_sequence|
				winning_sequence?(possible_sequence(possible_victory_sequence))
			end.inject(:|)
		end

		def filled_positions
			@game_board.select { |key, value| PLAYERS.values.include?(value)}
		end

		def possible_sequence(sequence)
			@game_board.select { |key, value| sequence.include?(key) }
		end

		def winning_sequence?(sequence)
			sequence.values.uniq.length == 1
		end
end