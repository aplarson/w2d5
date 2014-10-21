class PokerGame
  attr_reader :players, :pot

  def initialize(players)
    @players = players
    @pot = 0
  end

  def deal_new_hand
    @deck = Deck.new
    5.times do
	  @players.each do |player|
	    player.hand << @deck.draw(1)
	  end
	end
	@players.each do |player|
	  player.ante_up
      @pot += player.pot
    end
  end

  def get_ante
  end
end