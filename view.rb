class View

  def view_board(board)
    str = " Q Q Q Q Q Q Q Q Q Q Q Q\n "
    board.each {|row| str <<"Q " + row.join(" ") + " Q\n " }
    str << "Q Q Q Q Q Q Q Q Q Q Q Q"
    puts str
  end

  def place_ship(ship)
    puts "where do you want to place your #{ship.name}, it is #{ship.taken_space.length} spaces long"
    STDIN.gets.chomp
  end
end