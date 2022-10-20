class  Noughts_and_Crosses
  attr_accessor :player1, :player1_symbol, :player2, :player2_symbol, :move_coordinates,
                :toggle

  def initialize(name1, symbol1, name2, symbol2)
    self.player1 = name1
    self.player1_symbol = symbol1
    self.player2 = name2
    self.player2_symbol = symbol2
    self.move_coordinates = {11=>' ', 12=>' ',13=>' ', 21=>' ', 22=>' ', 23=>' ', 31=>' ', 32=>' ',
                        33=>' '}
    self.toggle = true
  end

  def print_board
    move_coordinates.each do |key, value|
      print value
      if(key % 10 == 3) 
          print "\n--+---+--\n" unless key/10 == 3
          next
      else
          print " | "
      end
    end
  end

  def make_move
    coordinate = gets.chomp.to_i
    if toggle == true
        move_coordinates[coordinate] = 'X' 
        self.toggle = false
    else
        move_coordinates[coordinate] = '0'
        self.toggle = true
    end
  end

  def check_for_win
    
  end
end

  

setup = Noughts_and_Crosses.new('Jack', 'X', 'Jill', '0')

9.times do
  setup.make_move
  print_board
  check_for_win
end
