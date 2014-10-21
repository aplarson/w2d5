require 'game'

describe "Game" do
  describe "dealing a new hand" do
  	subject(:game) { PokerGame.new([Player.new, Player.new, Player.new, Player.new])}

    it "gives each player 5 cards" do
      game.deal_new_hand
      expect(game.players.all? { |player| player.hand.length == 5}).to be_true
    end

    describe "collects ante from each player" do
      subject(:game) { PokerGame.new([Player.new, Player.new, Player.new, Player.new])}

      it "gets a bet from each player" do
      	game.deal_new_hand
        expect(game.players.all? { |player| player.pot == 1 }).to be_true
        expect(game.players.all? { |player| player.bankroll == 99 }).to be_true
      end

      it "puts all the antes into the pot" do
      	game.deal_new_hand
      	expect(game.pot).to eq(4)
      end
    end
  end

  describe "taking bets"

  describe "the draw round"

  describe "showing down hands"
end