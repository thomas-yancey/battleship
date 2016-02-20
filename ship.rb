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
end

class Ship
  attr_reader :name, :taken_space, :alive, :coordinates

  def initialize(name, length)
    @name = name
    @taken_space = Array.new(length) {"#{name[0].upcase}"}
    @alive = true
    @coordinates = []
  end

  def place_ship(coordinates)
    @coordinates << coordinates
  end

  def sunk?
    @coordinates.empty?
  end
end