#Chess Settings
#Definition of Board, ChessPiece (Inluding moves on board) Classes 
#Rook, Bishop, Queen, King, Knight and Pawn Classes < ChessPiece

class ChessPiece
	def initialize(present_position)
		@present_position = present_position
	end
	def difference_axis(present_position, expected_position)
 		diff_x = expected_position[0] - @present_position[0]
		diff_y = expected_position[1] - @present_position[1]
		[diff_x.abs, diff_y.abs]
 	end
	def check_diagonally (present_position, expected_position)
		diff_x, diff_y = difference_axis(present_position, expected_position)
		diff_x == diff_y
 	end
 	def check_straight(present_position, expected_position)	
		present_position[0] == expected_position[0] || present_position[1] == expected_position[1]
 	end
end

class Rook < ChessPiece
	def check_move(expected_position)
		@expected_position = expected_position
		if check_straight(@present_position, @expected_position)
			true
		else
			false
		end
	end
end

class Bishop < ChessPiece
	def check_move(expected_position)
		@expected_position = expected_position
		if check_diagonally(@present_position, @expected_position)
			true
		else
			false
		end
	end
end

class Queen < ChessPiece
	def check_move(expected_position)
		@expected_position = expected_position
		if check_diagonally(@present_position, @expected_position) != check_straight(@present_position, @expected_position)
			true
		else
			false
		end
	end
end

class King < ChessPiece
	def check_move(expected_position)
		@expected_position = expected_position
		diff_x, diff_y = difference_axis(@present_position, @expected_position)
		if diff_x <= 1 && diff_y <= 1
			true
		else
			false
		end
	end
end

class Knight < ChessPiece
	def check_move(expected_position)
		@expected_position = expected_position
		diff_x, diff_y = difference_axis(@present_position, @expected_position)
		if diff_x == 1 && diff_y == 2
			veredict = true
		elsif diff_x == 2 && diff_y == 1
			true
		else
			false
		end
	end
end

class Pawn < ChessPiece
	def check_move(expected_position, colour)
		@expected_position = expected_position
		@colour = colour
		diff_x = @expected_position[0] - @present_position[0]
		if @colour == "b" && diff_x.between?(1,2)
			check_straight(@present_position, @expected_position)
		elsif @colour == "w" && diff_x.between?(-2,-1)
			check_straight(@present_position, @expected_position)
		else
			false
		end
	end
end

class Board
	attr_accessor :board
	def initialize
		@board = []
	end
	def simple
		@board = [
			[:bR, :bN, :bB, :bQ, :bK, :bB, :bN, :bR],
			[:bP, :bP, :bP, :bP, :bP, :bP, :bP, :bP],
			[nil, nil, nil, nil, nil, nil, nil, nil],
			[nil, nil, nil, nil, nil, nil, nil, nil],
			[nil, nil, nil, nil, nil, nil, nil, :wP],
			[nil, nil, nil, nil, nil, nil, nil, nil],
			[:wP, :wP, :wP, :wP, :wP, :wP, :wP, :wP],
			[:wR, :wN, :wB, :wQ, :wK, :wB, :wN, :wR]
		]
	end
end

