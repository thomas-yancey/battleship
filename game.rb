require_relative 'ship'
require_relative = 'view.rb'

class Game
  attr_reader :player_one, :player_two, :players
  def initialize(args={})
    @player_one = Player.new(name: "player one")
    @player_two = Player.new(name: "player two")
    @turn_count = 0
    @players = [@player_one,@player_two]
  end

  def player_rotate
    @players.rotate!
  end

  def guess(coordinates,player_defending)
    row, col = coordinates[0], coordinates[1]
    if player_defending.board.hit?(row,col) != false
     ship = player_defending.fleet.find_ship_hit(row,col)
     p ship
     puts "you hit my #{ship.name}"
     index = ship.coordinates.index([row,col])
     ship.coordinates.delete_at(index)
     player_defending.board.board[row][col] = "X"
     if ship.sunk?
      puts "you sunk my #{ship.name}"
     end
    end
  end

end

class Player
  attr_reader :name, :board, :fleet
  def initialize(args={})
    @name = args.fetch(:name, "You gotta give me a name")
    @board = Board.new
    @fleet = Fleet.new
    @view = View.new
    place_fleet
  end

  def fleet_placed?
    @fleet.ships.each {|ship| return false if ship.coordinates.empty? }
    true
  end

  def find_next_ship
    @fleet.ships.find {|ship| ship if ship.coordinates.empty? }
  end

  ##try to figure out a way to pass the getting responsibility to the view, you may have to do each item one at a time. Also figure out the bug that is causing the forever loop if you give it a wrong answer
  def place_fleet
    count = 1

    puts "#{name} lets place your ships"
    @fleet.ships.each do |ship|
      count += 1
      puts "where do you want to place your #{ship.name}, it is #{ship.taken_space.length} spaces long, horizontal or vertical? h/v"
      # direction_answer = STDIN.gets.chomp
      direction_answer = STDIN.gets.chomp

      until direction_answer == "h" || direction_answer == "v"
        puts "horizontal or vertical, you gotta choose"
        direction_answer = STDIN.gets.chomp
      end

      if direction_answer == "h"
        puts "where at? seperate coordinates with comma"
        # coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i}

        until @board.place_horizontal_possible(coordinates,ship)
          puts "not gonna work, try again"
          coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        end
        @board.place_horizontal(coordinates,ship)
      else
        puts "where at? seperate coordinates with comma"
        coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        until validate_coordinates(coordinates) == true && @board.place_vertical_possible(coordinates,ship)
          puts "not gonna work, try again"
          coordinates = STDIN.gets.chomp.split(",").map {|x| x.to_i }
        end
        @board.place_vertical(coordinates,ship)
      end
      @view.view_board(@board.board)
    end
  end

  def validate_coordinates(answer)
    answer.join(",").match(/\A[0-9],[0-9]/) ? true : false
  end
end
