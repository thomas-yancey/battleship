class Fleet
  attr_reader :ships
  def initialize
    @ships = []
    @ships << @carrier = Ship.new("CARRIER", 5)
    @ships << @battleship = Ship.new("BATTLESHIP", 4)
    @ships << @cruiser = Ship.new("CRUISER", 3)
    @ships << @destroyer_one = Ship.new("DESRTOYER_ONE", 2)
    @ships << @destroyer_two = Ship.new("DESRTOYER_TWO", 2)
    @ships << @submarine_one = Ship.new("SUBMARINE_ONE", 1)
    @ships << @submarine_one = Ship.new("SUBMARINE_TWO", 1)
  end
  def find_ship_hit(row,col)
    ship = @ships.find {|ship| ship.coordinates.include?([row,col])}
    ship ? ship : false
  end

  def all_ships_sunk?
    @ships.all? {|ship| ship.sunk? }
  end

end

class Ship
  attr_reader :name, :taken_space, :sunk, :coordinates

  def initialize(name, length)
    @name = name
    @taken_space = Array.new(length) {"#{name[0].upcase}"}
    @sunk = false
    @coordinates = []
  end

  def place_ship(coordinates)
    @coordinates << coordinates
  end

  def sunk?
    @sunk = true if @coordinates.empty?
    @sunk
  end

  def ship_placed?
    !@coordinates.empty?
  end

end
