require_relative './card.rb'

class Deck
  attr_reader :cards
  def initialize
    @cards = shuffle_cards
  end
  
  def shuffle_cards
    result = []
    Card.suits.each do |suit|
      Card.ranks.each do |rank|
        result << Card.new(suit, rank)
      end
    end
    result.shuffle
  end
  
  def draw(num)
    result = []
    num.times do
      result << cards.shift 
    end
    result
  end
  
end