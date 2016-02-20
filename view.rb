class View

  def view_board(board)
    str = " Q Q Q Q Q Q Q Q Q Q Q Q\n "
    board.each {|row| str <<"Q " + row.join(" ") + " Q\n " }
    str << "Q Q Q Q Q Q Q Q Q Q Q Q"
    puts str
  end

  def direction_input(ship)
    puts "where do you want to place your #{ship.name}, it is #{ship.taken_space.length} spaces long, horizontal or vertical? h/v"
    direction_answer = STDIN.gets.chomp

    until direction_answer == "h" || direction_answer == "v"
      puts "horizontal or vertical, you gotta choose"
      direction_answer = STDIN.gets.chomp
    end
    direction_answer
  end

  def location_input(board)
    puts "where at? seperate coordinates with comma"
    view_board(board)
    answer = STDIN.gets.chomp.split(",").map {|x| x.to_i }
    #make it have a length of 3 and have a comma later
  end

  def location_wrong
    puts "not gonna work, try again"
    STDIN.gets.chomp.split(",").map {|x| x.to_i }
  end

  def guess(player)
    puts "#{player}, where do you want to strike"
    answer = STDIN.gets.chomp.split(",").map {|x| x.to_i}
  end

end
