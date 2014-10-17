require 'hand.rb'

describe "Hand" do
  subject(:hand) {Hand.new}
  it "should be able to recieve cards" do
    hand.add_cards([Card.new(:spades, :four)])
    expect(hand.cards.length).to eq(1)
  end
  
  describe "after being dealt" do
    before(:each) do
      hand.add_cards([Card.new(:spades, :four), Card.new(:hearts, :four), 
                      Card.new(:diamonds, :four), Card.new(:clubs, :four),
                      Card.new(:diamonds, :three)])
    end
    it "consists of cards" do
      expect(hand.cards.all? {|card| card.is_a?(Card) }).to be_true
    end
    it "limits size to five cards" do 
      expect { hand.add_cards([Card.new(:spades, :king)]) }
        .to raise_error("TOO MANY CARDS")
    end
    it "should be able to get rid of cards" do
    end
    it "tells what hand it is"
    it "tells what hands beat other hands"
  end
end