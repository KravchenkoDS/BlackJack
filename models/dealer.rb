require_relative '../models/player'
require_relative '../common/game_rules'
class Dealer < Player
  def initialize(name = 'Dealer')
    super(name)
  end

  def can_take_card?
    points < GameRules::MAX_DEALER_POINTS && cards.size < GameRules::MAX_CARDS
  end
end
