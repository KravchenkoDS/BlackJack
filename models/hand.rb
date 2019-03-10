class Hand
  attr_reader :cards

  def initialize
    @cards = []
    @points = 0
  end

  def reset
    @cards = []
    @points = 0
  end

  def give_card(deck)
    @cards << deck.give_card
    ace_corrector_point
  end

  def points
    @cards.map(&:point).sum
  end

  private

  def ace_corrector_point
    @cards.each do |card|
      card.point -= GameRules::MIN_VALUE_ACE if card.ace? && @points > GameRules::MAX_POINTS
    end
  end
end
