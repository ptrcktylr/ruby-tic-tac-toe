require '/Users/patrick/Documents/the-odin-project/tic-tac-toe/board.rb'
require '/Users/patrick/Documents/the-odin-project/tic-tac-toe/player.rb'

class Game

  def initialize(size)
    @board = Board.new(size)
    @players = [Player.new(:X), Player.new(:O)]
  end

  def current_player # return player at start of player array
    @players[0]
  end

  def previous_player
    @players[-1]
  end

  def run
    until over?
      @board.display
      move
    end

    if @board.won?
      puts "Player #{previous_player.mark} wins!"
    end

    if @board.tied?
      puts "It's a tie!"
    end

  end

  def over? # check if won or tied
    @board.won? || @board.tied?
  end

  def switch_players! # swap to next player in arr
    @players.rotate!
  end

  def move # put player mark at pos if its valid
    puts "Player #{current_player.mark}, enter a coordinate to fill (e.g. 1, 2)"
    input = gets.chomp
    pos = input.split(",").map(&:to_i)

    until @board.valid_pos?(pos)
      puts "Invalid input '#{pos}'! Make sure numbers comma seperated"
      puts "Player #{current_player.mark}, enter a coordinate to fill (e.g. 1, 2)"
      input = gets.chomp
      pos = input.split(",").map(&:to_i)
    end

    if @board.empty?(pos) == false
      puts "That position is not empty!"
      sleep(1.2)
      return false
    else
      @board[pos] = current_player.mark
      switch_players!
      return true
    end

  end

end

game = Game.new(3)
game.run