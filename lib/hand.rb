class Hand
  attr_reader :cards
  def initialize
    @cards = []
  end
  
  def add_cards(spec_cards)
    raise "TOO MANY CARDS" if (cards.size + spec_cards.size) > 5
    @cards += spec_cards
  end
  
  def discard(spec_cards)
  end
end