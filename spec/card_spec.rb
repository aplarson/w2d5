require 'card.rb'

describe "Card" do
  it "has a suit and rank" do
    card = Card.new(:spades, :king)
    expect(card.suit).to eq(:spades)
    expect(card.rank).to eq(:king)
  end
  
  describe "suits" do
    it "returns the four suits" do
      expect(Card.suits).to eq([:hearts, :diamonds, :spades, :clubs])
    end
    it "returns the values of cards" do
      expect(Card.ranks).to eq([:ace, 
            :king, 
            :queen, 
            :jack, 
            :ten, 
            :nine,
            :eight, 
            :seven, 
            :six, 
            :five, 
            :four, 
            :three, 
            :two])
    end
  end
end