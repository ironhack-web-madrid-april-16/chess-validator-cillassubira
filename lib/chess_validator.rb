#ChessValidator Simple Moves
#Game Class validates moves from plays file according to a set Board
#Saves LEGAL or ILLEGAL on destination file
require 'pry'
require './chess_settings.rb'

class Game

  def initialize(board, plays_file, veredicts_file)
    @board = board
    @veredicts = []
    @plays = download_plays_txt(plays_file) 
    @veredicts_file = veredicts_file
  end

  def start
    @plays.each_with_index do |move, index|
      if index%2 == 0
        @ending_position_x, @ending_position_y = conv_chess_to_cartesian(@plays[index+1])
        ending_position_check = check_piece_board(@ending_position_x, @ending_position_y)
        
        if ending_position_check == nil
          @present_position_x, @present_position_y = conv_chess_to_cartesian(move)
          piece = check_piece_board(@present_position_x, @present_position_y)
          veredict = guess_piece(piece)
        else
          veredict = false
        end
        conversor_veredict(veredict)
      end
      save_veredict_txt(@veredicts, @veredicts_file)
    end
  end

  def download_plays_txt(plays_file)
    plays = IO.read(plays_file).tr(" ", "\n")
    plays = plays.split("\n")
  end

  def conversor_veredict(veredict)
    veredict ? (@veredicts << "LEGAL") : (@veredicts << "ILLEGAL")
  end

  def save_veredict_txt(veredicts, veredicts_file)
    IO.write(@veredicts_file,veredicts.join("\n"))
  end

  def conv_chess_to_cartesian(position)
    cartesian_x = [8, 7, 6, 5, 4, 3, 2, 1].index(position[1].to_i)
    cartesian_y = ["a","b","c","d","e","f","g","h"].index(position[0])
    [cartesian_x, cartesian_y]
  end

  def check_piece_board(position_x, position_y)
    piece = @board[position_x][position_y]
  end

  def guess_piece(piece)
    case piece
    when :bR, :wR
      rook = Rook.new([@present_position_x, @present_position_y])
      rook.check_move([@ending_position_x, @ending_position_y])
    when :bN, :wN
      knight = Knight.new([@present_position_x, @present_position_y])
      knight.check_move([@ending_position_x, @ending_position_y])
    when :bB, :wB
      bishop = Bishop.new([@present_position_x, @present_position_y])
      bishop.check_move([@ending_position_x, @ending_position_y])
    when :bQ, :wQ
      queen = Queen.new([@present_position_x, @present_position_y])
      queen.check_move([@ending_position_x, @ending_position_y])
    when :bK, :WK
      king = King.new([@present_position_x, @present_position_y])
      king.check_move([@ending_position_x, @ending_position_y])
    when :bP
      pawn = Pawn.new([@present_position_x, @present_position_y])
      pawn.check_move([@ending_position_x, @ending_position_y], "b")
    when :wP
      pawn = Pawn.new([@present_position_x, @present_position_y])
      pawn.check_move([@ending_position_x, @ending_position_y], "w")
    else
      false
    end
  end
end

board_simple = Board.new.simple
game_simple = Game.new(board_simple, 'simple_moves.txt', 'simple_results.txt').start

board_complex = Board.new.complex
game_complex = Game.new(board_complex, 'complex_moves.txt', 'complex_results.txt').start