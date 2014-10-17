require 'hand.rb'
require 'debugger'

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
      leftover_hand = hand.cards[1..4]
      hand.discard([hand.cards[0]])
      expect(hand.cards).to eq(leftover_hand)
    end
  end
  
  describe "when showing down" do
    
    describe "tells what hand it is" do
        let(:king_high) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :king), 
                              Card.new(:hearts, :ten), 
                              Card.new(:diamonds, :seven), 
                              Card.new(:clubs, :four),
                              Card.new(:diamonds, :three)])
          hand
         end
        let(:pair_of_aces) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :ace), 
                              Card.new(:hearts, :ace), 
                              Card.new(:diamonds, :seven), 
                              Card.new(:clubs, :four),
                              Card.new(:diamonds, :three)])
          hand
        end
        let(:kings_over_sevens) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :king), 
                              Card.new(:hearts, :king), 
                              Card.new(:diamonds, :seven), 
                              Card.new(:clubs, :seven),
                              Card.new(:diamonds, :two)])
          hand
        end
        let(:three_threes) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :three), 
                              Card.new(:hearts, :five), 
                              Card.new(:diamonds, :three), 
                              Card.new(:clubs, :three),
                              Card.new(:diamonds, :two)])
          hand
        end
        let(:straight_to_7) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :five), 
                              Card.new(:hearts, :six), 
                              Card.new(:diamonds, :seven), 
                              Card.new(:clubs, :four),
                              Card.new(:diamonds, :three)])
          hand
        end
        let(:ten_high_flush) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :five), 
                              Card.new(:spades, :six), 
                              Card.new(:spades, :ten), 
                              Card.new(:spades, :four),
                              Card.new(:spades, :three)])
          hand
        end
        let(:threes_full_of_twos) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :three), 
                              Card.new(:hearts, :two), 
                              Card.new(:diamonds, :three), 
                              Card.new(:clubs, :three),
                              Card.new(:diamonds, :two)])
          hand
        end
        let(:four_fours) do 
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :four), 
                              Card.new(:hearts, :four), 
                              Card.new(:diamonds, :four), 
                              Card.new(:clubs, :four),
                              Card.new(:diamonds, :three)])
          hand
        end
        let(:straight_flush) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :five), 
                              Card.new(:spades, :six), 
                              Card.new(:spades, :seven), 
                              Card.new(:spades, :four),
                              Card.new(:spades, :three)])
          hand
        end
        let(:straight_to_five) do
          hand = Hand.new
          hand.add_cards([Card.new(:spades, :five), 
                              Card.new(:hearts, :two), 
                              Card.new(:diamonds, :ace), 
                              Card.new(:clubs, :four),
                              Card.new(:diamonds, :three)])
          hand
        end
      it "knows it is a high card hand" do
        expect(king_high.hand_type).to eq(:high_card)
      end
      it "knows when it is a pair" do
        expect(pair_of_aces.hand_type).to eq(:pair)
      end
      
      it "knows when it is a two pair" do
        expect(kings_over_sevens.hand_type).to eq(:two_pair)
      end
      it "knows when it is a three of a kind" do
        expect(three_threes.hand_type).to eq(:three_of_a_kind)
      end
      it "knows when it is a straight" do
        expect(straight_to_7.hand_type).to eq(:straight)
      end
      it "knows when it is a flush" do
        expect(ten_high_flush.hand_type).to eq(:flush)
      end
      it "knows when it is a full house" do
        expect(threes_full_of_twos.hand_type).to eq(:full_house)
      end
      it "knows when it is a four of a kind" do
        expect(four_fours.hand_type).to eq(:four_of_a_kind)
      end
      it "knows when it is a straight flush" do
        expect(straight_flush.hand_type).to eq(:straight_flush)
      end
      it "knows that an ace can be low in a straight" do
        expect(straight_to_five.hand_type).to eq(:straight)
      end
    end
    describe "what hands beat other hands" do
      let(:king_high) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :king), 
                            Card.new(:hearts, :ten), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :four),
                            Card.new(:diamonds, :three)])
        hand
       end
      let(:pair_of_aces) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :ace), 
                            Card.new(:hearts, :ace), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :four),
                            Card.new(:diamonds, :three)])
        hand
      end
      let(:kings_over_sevens) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :king), 
                            Card.new(:hearts, :king), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :seven),
                            Card.new(:diamonds, :two)])
        hand
      end
      let(:three_threes) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :three), 
                            Card.new(:hearts, :five), 
                            Card.new(:diamonds, :three), 
                            Card.new(:clubs, :three),
                            Card.new(:diamonds, :two)])
        hand
      end
      let(:straight_to_7) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :five), 
                            Card.new(:hearts, :six), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :four),
                            Card.new(:diamonds, :three)])
        hand
      end
      let(:ten_high_flush) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :five), 
                            Card.new(:spades, :six), 
                            Card.new(:spades, :ten), 
                            Card.new(:spades, :four),
                            Card.new(:spades, :three)])
        hand
      end
      let(:threes_full_of_twos) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :three), 
                            Card.new(:hearts, :two), 
                            Card.new(:diamonds, :three), 
                            Card.new(:clubs, :three),
                            Card.new(:diamonds, :two)])
        hand
      end
      let(:four_fours) do 
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :four), 
                            Card.new(:hearts, :four), 
                            Card.new(:diamonds, :four), 
                            Card.new(:clubs, :four),
                            Card.new(:diamonds, :three)])
        hand
      end
      let(:straight_flush) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :five), 
                            Card.new(:spades, :six), 
                            Card.new(:spades, :seven), 
                            Card.new(:spades, :four),
                            Card.new(:spades, :three)])
        hand
      end
      let(:straight_to_five) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :five), 
                            Card.new(:hearts, :two), 
                            Card.new(:diamonds, :ace), 
                            Card.new(:clubs, :four),
                            Card.new(:diamonds, :three)])
        hand
      end
      let(:straight_to_king) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :king), 
                            Card.new(:hearts, :queen), 
                            Card.new(:diamonds, :jack), 
                            Card.new(:clubs, :ten),
                            Card.new(:diamonds, :nine)])
        hand
      end
      let(:pair_of_eights) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :eight), 
                            Card.new(:hearts, :eight), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :four),
                            Card.new(:diamonds, :three)])
        hand
      end
      let(:queens_over_sixes) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :queen), 
                            Card.new(:hearts, :queen), 
                            Card.new(:diamonds, :six), 
                            Card.new(:clubs, :six),
                            Card.new(:diamonds, :two)])
        hand
      end
      let(:three_sevens) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :seven), 
                            Card.new(:hearts, :five), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :seven),
                            Card.new(:diamonds, :two)])
        hand
      end
      let(:sevens_full_of_sixes) do
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :seven), 
                            Card.new(:hearts, :six), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :seven),
                            Card.new(:diamonds, :six)])
        hand
      end
      let(:four_sevens) do 
        hand = Hand.new
        hand.add_cards([Card.new(:spades, :seven), 
                            Card.new(:hearts, :seven), 
                            Card.new(:diamonds, :seven), 
                            Card.new(:clubs, :seven),
                            Card.new(:diamonds, :three)])
        hand
      end
      it "knows that a pair beats high card" do
        expect(pair_of_aces.beats?(king_high)).to be_true
      end
      it "knows that a two pair beats a pair" do
        expect(kings_over_sevens.beats?(pair_of_aces)).to be_true
      end
      it "knows that a three of a kind beats a two pair" do
        expect(three_threes.beats?(kings_over_sevens)).to be_true
      end
      it "knows that a straight beats a three of a kind" do
        expect(straight_to_five.beats?(three_threes)).to be_true
      end
      it "knows that a flush beats a straight" do
        expect(ten_high_flush.beats?(straight_to_five)).to be_true
      end
      it "knows that a full house beats a flush" do
        expect(threes_full_of_twos.beats?(ten_high_flush)).to be_true
      end
      it "knows that a four of a kind beats a full house" do
        expect(four_fours.beats?(threes_full_of_twos)).to be_true
      end
      it "knows that a straight flush beats a four of a kind" do
        expect(straight_flush.beats?(four_fours)).to be_true
      end
      it "knows that a larger straight beats a smaller straight" do
        expect(straight_to_king.beats?(straight_to_7)).to be_true
      end
      it "correctly compares A-5 straights" do
        expect(straight_to_five.beats?(straight_to_7)).to be_false
      end
      it "compares pairs" do
        expect(pair_of_aces.beats?(pair_of_eights)).to be_true
      end
      it "compares full house" do
        expect(threes_full_of_twos.beats?(sevens_full_of_sixes)).to be_false
      end
      it "compares threes of a kind" do
        expect(three_threes.beats?(three_sevens)).to be_false
      end
      it "compares two pairs" do
        expect(kings_over_sevens.beats?(queens_over_sixes)).to be_true
      end
      it "compares four of a kind" do
         expect(four_fours.beats?(four_sevens)).to be_false
      end
    end
  end
end