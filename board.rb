class Board
  attr_reader :board

  def initialize(args={})
    @board = args.fetch(:board, Array.new(10) {["-","-","-","-","-","-","-","-","-","-",]})
  end

  def place_vertical_possible(location_array,ship)
    row, col = location_array[0], location_array[1]

    return false if row + ship.taken_space.length > board.size
    return false if @board.transpose[col][row..row + ship.taken_space.length].uniq.length != 1

    ship.taken_space.length.times do
      return false if @board[row][col] != "-"
      row += 1
    end
    true
  end

  def place_horizontal_possible(location_array,ship)
    row, col = location_array[0], location_array[1]

    return false if col + ship.taken_space.length > board.size
    return false if @board[row][col..col + ship.taken_space.length].uniq.length != 1
    ship.taken_space.length.times do
      return false if @board[row][col] != "-"
      col += 1
    end
    true
  end

  def place_vertical(location_array,ship)
    row, col = location_array[0], location_array[1]

    return false if row + ship.taken_space.length > board.size
    return false if @board.transpose[col][row..row + ship.taken_space.length].uniq.length != 1

    ship.taken_space.length.times do
      @board[row][col] = ship.taken_space[0]
      ship.place_ship([row,col])
      row += 1
    end
  end

  def place_horizontal(location_array,ship)
    row, col = location_array[0], location_array[1]

    return false if col + ship.taken_space.length > board.size
    return false if @board[row][col..col + ship.taken_space.length].uniq.length != 1
    ship.taken_space.length.times do
      @board[row][col] = ship.taken_space[0]
      ship.place_ship([row,col])
      col += 1
    end
  end

  def hit?(row,col)
    return false if @board[row][col] == "-"
    return false if @board[row][col] == "X"
    true
  end

end

