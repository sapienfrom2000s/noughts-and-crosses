 frozen_string_literal: true

# require 'pry-by ebug'

class NoughtsAndCrosses
  attr_accessor :player1, :player1_symbol, :player2, :player2_symbol, :move_coordinates,
                :toggle, :player1_moves, :player2_moves, :game_state

  def initialize(name1, symbol1, name2, symbol2)
    puts("Enter your move in coordinates ranging from 11 to 33\nPlayer1: Jack(X)\nPlayer2: Jill(0)")
    self.player1 = name1
    self.player1_symbol = symbol1
    self.player2 = name2
    self.player2_symbol = symbol2
    self.move_coordinates = { 11 => ' ', 12 => ' ', 13 => ' ', 21 => ' ', 22 => ' ', 23 => ' ', 31 => ' ', 32 => ' ',
                              33 => ' ' }
    self.toggle = 'X'
    self.player1_moves = []
    self.player2_moves = []
  end

  def print_board
    puts
    move_coordinates.each do |key, value|
      print value
      if key % 10 == 3
        print "\n--+---+--\n" unless key / 10 == 3
        next
      else
        print ' | '
      end
    end
    puts "\n\n"
  end

  def make_valid_move
    flag = true
    coordinate = nil
    while flag
      coordinate = gets.chomp.to_i
      flag = false if move_coordinates[coordinate] == ' '
      puts 'Enter valid move' if flag == true
    end
    coordinate
  end

  def save_move(coordinate)
    if toggle == 'X'
      move_coordinates[coordinate] = 'X'
      player1_moves.push(coordinate)
    else
      move_coordinates[coordinate] = '0'
      player2_moves.push(coordinate)
    end
  end

  def check_for_win
    if (horizontal_cut || vertical_cut || diagonal_cut) == true
      if toggle == 'X'
        self.game_state = 'end'
        print "\nJack wins the game\n"
      else
        self.game_state == 'end'
        print "\nJill wins the game\n"
      end
    end
  end

  def horizontal_cut
    player_moves = toggle == 'X' ? player1_moves : player2_moves
    divisional_array = player_moves.map { |coordinate| coordinate / 10 }
    # binding.pry
    if divisional_array.count(1) == 3 || divisional_array.count(2) == 3 || divisional_array.count(3) == 3
      true
    else
      false
    end
  end

  def vertical_cut
    player_moves = toggle == 'X' ? player1_moves : player2_moves
    modulus_array = player_moves.map { |coordinate| coordinate % 10 }
    if modulus_array.count(1) == 3 || modulus_array.count(2) == 3 || modulus_array.count(3) == 3
      true
    else
      false
    end
  end

  def diagonal_cut
    player_moves = toggle == 'X' ? player1_moves : player2_moves
    forward_diagonal_cut = player_moves.select { |coordinate| coordinate / 10 == coordinate % 10 }
    backward_diagonal_cut = player_moves.select do |coordinate|
      (coordinate / 10 - coordinate % 10).abs == 2 || coordinate == 22
    end
    if backward_diagonal_cut.length == 3 || forward_diagonal_cut.length == 3
      true
    else
      false
    end
  end

  def toggle_state
    # binding.pry
    case toggle
    when 'X'
      self.toggle = '0'
    when '0'
      self.toggle = 'X'
    end
  end
end

setup = NoughtsAndCrosses.new('Jack', 'X', 'Jill', '0')

(1..9).each do |i|
  move = setup.make_valid_move
  setup.save_move(move)
  setup.print_board
  setup.check_for_win
  setup.toggle_state
  break if setup.game_state == 'end'

  puts 'DRAW' if i == 9
end
