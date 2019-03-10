class Dealer < Player
  def initialize(name = 'Dealer')
    super(name)
  end

  def can_take_card
    hand.points < GameRules::MAX_DEALER_POINTS && hand.cards.size < GameRules::MAX_CARDS
  end
end
