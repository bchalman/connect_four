require './lib/connect_four.rb'

describe Game do
  class Game
    public :switch_player, :valid_input?, :update_board_values, :winning_move?
    attr_accessor :last_token_placed
  end
  game = Game.new('Bob', 'Sally')

  describe '#valid_input?' do
    it 'returns true when given a number between 1 and 7' do
      expect(game.valid_input?(3)).to be true
    end
    it 'returns false when given a number outside 1 to 7' do
      expect(game.valid_input?(0)).to be false
    end
    it 'returns false when given a column that is already full' do
      game.board[0] = ['x','x','x','x','x','x'] # fill column 1
      expect(game.valid_input?(1)).to be false
    end
  end

  describe '#update_board_values' do
    it 'Adds the current player symbol to the selected column' do
      game.update_board_values(1)
      expect(game.board[1]).to eq(['X', "•", "•", "•", "•", "•"])
    end
  end

  describe '#switch_player' do
    it 'changes the current player to the opposite player' do
      expect(game.current_player).to eq(game.player1)
      game.switch_player
      expect(game.current_player).to eq(game.player2)
    end
  end

  describe '#winning_move?' do
    it 'returns true if four of the same tokens make a horizontal line' do
      0.upto(3) do |i|
        game.board[i][0] = 'X'
      end
      game.last_token_placed = [3,0]
      expect(game.winning_move?).to be true
    end

    it 'returns true if four of the same tokens make a vertical line' do
      0.upto(3) do |i|
        game.board[0][i] = 'O'
      end
      game.last_token_placed = [0,3]
      expect(game.winning_move?).to be true
    end

    it 'returns true if four of the same tokens make a diagonal line' do
      0.upto(3) do |i|
        game.board[i][i] = 'X'
      end
      game.last_token_placed = [3,3]
      expect(game.winning_move?).to be true
    end
  end

end
