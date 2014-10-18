require 'player.rb'

describe "Player" do
  subject(:player) {Player.new}
  it "has a hand" do
    expect(player).to respond_to(:hand)
  end
  it "has a pot" do
    expect(player).to respond_to(:hand)
  end
  describe "Discard method" do
    before(:each) do
       player.hand = Hand.new
       player.hand.add_cards([Card.new(:spades, :seven), 
                            Card.new(:hearts, :six), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :seven),
                            Card.new(:diamonds, :six)])
      player.hand
    end
    it "causes cards to be discarded" do
      player.discard(player.hand.cards)
      expect(player.hand.cards.length).to eq(0)
    end
    it "specifies the cards to be discarded" do
      returned_cards = player.hand.cards[3..4]
      player.discard(player.hand.cards[0..2])
      expect(player.hand.cards).to eq(returned_cards)
    end
  end
  describe "Betting rounds" do
    describe "takes a raise" do
      subject(:player) {Player.new}
      before(:each) { player.increase_bet(5, 7) }
      it "take money out of players bankroll" do
        expect(player.bankroll).to eq(93)
      end
      it "increases players pot" do
        expect(player.pot).to eq(7)
      end
      it "returns a higher bet than received" do
        expect(player.increase_bet(5, 7)).to eq(7)
      end
      it "should not reduce a player's bankroll below 0" do
        expect { player.increase_bet(7, 500) }.to raise_error("You're too poor")
      end
    end
    describe "takes a call" do
      before(:each) { player.call_bet(5) }
      it "takes money out of players bankroll" do
        expect(player.bankroll).to eq(95)
      end
      it "increases players pot" do
        expect(player.pot).to eq(5)
      end
      it "returns same bet" do
        expect(player.call_bet(5)).to eq(5)
      end
    end
    describe "takes a fold" do
      before(:each) { player.fold_bet(5) }
      it "empties the players hand" do
        expect(player.hand.cards.length).to eq(0)
      end
      it "notes that the player has folded" do
        expect(player.folded?).to be_true
      end
      it "returns the bet it received" do
        expect(player.fold_bet(5)).to eq(5)
      end
    end 
  end
end