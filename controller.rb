require_relative 'game'
require_relative 'board'
require_relative 'ship'
require_relative 'view'

require 'pry'
class Controller

  attr_reader :view, :game
  def initialize(args={})
    @view = View.new
    @game = Game.new
  end

  def play_game
    until @game.player_one.fleet.all_ships_sunk? || @game.player_two.fleet.all_ships_sunk?
    @game.player_rotate
    attacking_player = @game.players[0]
    defending_player = @game.players[1]

    guess = @view.guess(attacking_player)
    @view.view_board(defending_player.board.board)
    puts @game.guess(guess, defending_player)

    end

  end


end



