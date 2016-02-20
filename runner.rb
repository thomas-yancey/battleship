require_relative 'game'
require_relative 'board'
require_relative 'ship'
require_relative 'view'

view = View.new
game = Game.new(player_one: "first", player_two: "second")

p game
game.player_one.place_fleet