require_relative '../models/player'

class Dealer < Player
  MAX_DEALER_POINTS = 17
  MAX_CARDS = 3
  def initialize(name = 'Dealer')
    super(name)
  end

  def can_take_card?
    points < MAX_DEALER_POINTS && cards.size < MAX_CARDS
  end
end
