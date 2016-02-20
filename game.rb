require_relative 'ship'
require_relative 'view'
class Game
  attr_reader :player_one, :player_two
  def initialize(args={})
    @player_one = Player.new
    @player_two = Player.new
  end
end

class Player
  attr_reader :name, :board, :fleet
  def initialize(args={})
    @name = args.fetch(:name, "You gotta give me a name")
    @board = Board.new
    @fleet = Fleet.new
    @view = View.new
  end

  def fleet_placed?
    @fleet.ships.each {|ship| return false if ship.coordinates.empty? }
    true
  end

  ##try to figure out a way to pass the getting responsibility to the view, you may have to do each item one at a time. Also figure out the bug that is causing the forever loop if you give it a wrong answer
  def place_fleet
    @fleet.ships.each do |ship|
      puts "where do you want to place your #{ship.name}, it is #{ship.taken_space.length} spaces long, horizontal or vertical? h/v"
      direction_answer = STDIN.gets.chomp
      puts "horizontal or vertical, you gotta choose" until direction_answer == "h" || direction_answer == "v"

      if direction_answer == "h"
        puts "where at? seperate coordinates with comma"
        coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        until @board.place_horizontal(coordinates,ship)
          puts "not gonna work, try again"
          coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        end
      else
        puts "where at? seperate coordinates with comma"
        coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        until @board.place_vertical(coordinates,ship)
          puts "not gonna work, try again"
          coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        end
      end
      @view.view_board(@board.board)
    end
  end
end