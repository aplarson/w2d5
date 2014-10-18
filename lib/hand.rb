class Hand
  attr_reader :cards
  def initialize
    @cards = []
  end
  
  def add_cards(spec_cards)
    raise "TOO MANY CARDS" if (cards.size + spec_cards.size) > 5
    @cards.concat(spec_cards)
  end
  
  def discard(spec_cards)
    if spec_cards.length > cards.length
      raise "Can't discard more cards than are in your hand" 
    end
    @cards -= spec_cards
  end
  
  def hand_type
    rank_freqs = check_rank_frequencies.values
    suit_freqs = check_suits.values
    if straight? && suit_freqs.max == 5
      return :straight_flush
    elsif rank_freqs.max == 4
      return :four_of_a_kind
    elsif rank_freqs.max == 3 && rank_freqs.min == 2
      return :full_house
    elsif suit_freqs.max == 5
      return :flush
    elsif straight?
      return :straight
    elsif rank_freqs.max == 3
      return :three_of_a_kind
    elsif rank_freqs.max == 2 && rank_freqs.length == 3
      return :two_pair
    elsif rank_freqs.max == 2
      return :pair
    else
      return :high_card
    end  
  end
  
  def check_rank_frequencies
    same_rank = Hash.new(0)
    cards.each do |card|
      same_rank[card.rank] += 1
    end
    same_rank 
  end
  
  def straight?
    values = card_values
    return true if values == [0, 9, 10, 11, 12]
    (values.min..(values.max)).to_a == values
  end
  
  def check_suits
    suits = Hash.new(0)
    cards.each do |card|
      suits[card.suit] += 1
    end
    suits
  end
  
  def card_values
    values = []
    @cards.each do |card|
      values << Card.ranks.index(card.rank)
    end
    values.sort
  end
  
  def beats?(other_hand)
    if hand_rank < other_hand.hand_rank
      return true
    elsif hand_rank > other_hand.hand_rank
      return false
    end
    if [:straight_flush, :flush, :straight, :high_card].include?(hand_type)
      checking_values = card_values
      checking_values = [9, 10, 11, 12, 13] if checking_values == [0, 9, 10, 11, 12]
      opp_values = other_hand.card_values
      opp_values = [9, 10, 11, 12, 13] if opp_values == [0, 9, 10, 11, 12]
      if checking_values.min < opp_values.min
        return true
      else
        return false
      end
    elsif hand_type == :two_pair
      comp_card, opp_card = get_max_arg_freqs(other_hand)
      comp_ranks = comp_card.keys.map { |rank| Card.ranks.index(rank) }
      opp_ranks = opp_card.keys.map { |rank| Card.ranks.index(rank) }
      return comp_ranks.min < opp_ranks.min
    else
      comp_card, opp_card = get_max_arg_freqs(other_hand)
      comp_rank = Card.ranks.index(comp_card.keys[0])
      opp_rank = Card.ranks.index(opp_card.keys[0])
      return comp_rank < opp_rank
    end
  end
  
  def get_max_arg_freqs(other_hand)
    hand_freqs = check_rank_frequencies
    opp_freqs = other_hand.check_rank_frequencies
    comp_card = hand_freqs.select { |rank, freq| freq == hand_freqs.values.max}
    opp_card = opp_freqs.select { |rank, freq| freq == opp_freqs.values.max}
    [comp_card, opp_card]
  end
  
  def hand_rank
    HAND_ORDER.index(hand_type)
  end
  
  HAND_ORDER = [:straight_flush, 
                :four_of_a_kind,
                :full_house,
                :flush,
                :straight,
                :three_of_a_kind,
                :two_pair,
                :pair,
                :high_card]
end