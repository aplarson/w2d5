require 'deck.rb'

describe "Deck" do
  subject(:deck) {Deck.new}
  it "contains cards" do
    expect(deck.cards.all?{ |card| card.is_a?(Card) }).to be_true
  end
  it "begins with 52 cards" do # May also want to test for uniqueness
    expect(deck.cards.length).to eq(52)
  end
  it "does not contain duplicate cards" do
    expect(deck.cards.count { |card| card.suit == :spades }).to eq(13)
    expect(deck.cards.count { |card| card.rank == :king }).to eq(4)
  end
  it "begins with cards in a random order" do
    test_arr = []
    5.times do |i|
      test_arr << Card.new(Card.suits[0], Card.ranks[i])
    end 
    expect(deck.cards[0..4]).to_not eq(test_arr)
  end
  it "draws cards" do
    first_card = deck.cards[0]
    expect(deck.draw(1)).to eq([first_card])
  end
  it "takes cards from the deck when it draws" do
    deck.draw(1)
    expect(deck.cards.length).to eq(51)
  end
end