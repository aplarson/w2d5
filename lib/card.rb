class Card
  attr_reader :suit, :rank
  def initialize(suit, rank)
    @suit, @rank = suit, rank
  end
  
  SUITS = [:hearts, :diamonds, :spades, :clubs]
  RANKS = [:ace, 
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
            :two]
            
  def self.suits
    SUITS
  end
  
  def self.ranks
    RANKS
  end
end