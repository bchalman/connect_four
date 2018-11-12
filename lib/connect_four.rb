Player = Struct.new(:name, :symbol)

class Game
  attr_reader :board, :current_player, :player1, :player2, :last_token_placed

  def initialize(player1, player2)
    @player1 = Player.new(player1, 'X')
    @player2 = Player.new(player2, 'O')
    @board = Array.new(7) {Array.new(6, "•")}
    @current_player = @player1
    @last_token_placed = nil
    @turn = 1
  end

  def play
    loop do
      draw_board()
      update_board_values(get_column_selection())
      break if winning_move?() || draw?()
      switch_player()
      @turn += 1
    end

    draw_board()
    if winning_move?()
      win_message()
    elsif draw?()
      draw_messaage()
    end
  end

  private

  def update_board_values(column)
    lowest_open_spot = @board[column].index("•")
    @board[column][lowest_open_spot] = @current_player.symbol
    @last_token_placed = [column, lowest_open_spot]
  end

  def get_column_selection
    puts "\n#{@current_player.name}'s turn!"
    puts "Which column would you like to add a token to? (Enter a number from 1 to 7):"
    column = gets.chomp
    until valid_input?(column.to_i)
      puts "Please enter a number between 1 and 7. If a column is full, please select a different column."
      column = gets.chomp
    end
    column.to_i - 1
  end

  def valid_input?(choice)
    return false unless choice.between?(1,7)
    return false unless @board[choice-1].include?("•")
    true
  end

  def draw_board
    print "\n"
    5.downto(0) do |i|
      print "|"
      for j in 0..6 do
        print " #{@board[j][i]} |"
      end
      puts
    end
    print "  1   2   3   4   5   6   7\n"
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def winning_move?
    return true if horizontal_win? || vertical_win? || diagonal_win?
    false
  end

  def draw?
    return true if @turn == 42
    false
  end

  def horizontal_win?
    col = @last_token_placed[0]
    row = @last_token_placed[1]
    -3.upto(0) do |i|
      return true if  col + i >= 0 && col + i <= 3 &&
                      @board[col + i][row] == @board[col + i + 1][row] &&
                      @board[col + i][row] == @board[col + i + 2][row] &&
                      @board[col + i][row] == @board[col + i + 3][row]
    end
    false
  end

  def vertical_win?
    col = @last_token_placed[0]
    row = @last_token_placed[1]
    -3.upto(0) do |i|
      return true if  row + i >= 0 && row + i <= 2 &&
                      @board[col][row + i] == @board[col][row + i + 1] &&
                      @board[col][row + i] == @board[col][row + i + 2] &&
                      @board[col][row + i] == @board[col][row + i + 3]
    end
    false
  end

  def diagonal_win?
    col = @last_token_placed[0]
    row = @last_token_placed[1]
    -3.upto(0) do |i|
      return true if  row + i >= 0 && row + i <= 2 &&
                      col + i >= 0 && col + i <= 3 &&
                      @board[col + i][row + i] == @board[col + i + 1][row + i + 1] &&
                      @board[col + i][row + i] == @board[col + i + 2][row + i + 2] &&
                      @board[col + i][row + i] == @board[col + i + 3][row + i + 3]

      return true if  row - i >= 0 && row - i <= 2 &&
                      col + i >= 0 && col + i <= 3 &&
                      @board[col + i][row - i] == @board[col + i + 1][row - i - 1] &&
                      @board[col + i][row - i] == @board[col + i + 2][row - i - 2] &&
                      @board[col + i][row - i] == @board[col + i + 3][row - i - 3]
    end
    false
  end

  def win_message
    puts "Congratulations #{current_player.name}! You Win!"
  end

  def draw_messaage
    puts "It's a draw! No winners."
  end
end
