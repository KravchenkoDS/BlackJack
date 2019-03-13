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
  end

  def points
    points_sum = @cards.map(&:point).sum
    ace_correction(points_sum)
  end

  private

  def ace_correction(points)
    @cards.each do |card|
      points -= GameRules::MIN_VALUE_ACE if card.ace? && points > GameRules::MAX_POINTS
    end
    points
  end
end
