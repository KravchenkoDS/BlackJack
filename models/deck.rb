require_relative '../models/player'
require_relative '../models/dealer'
require_relative '../models/bank'


class Deck
  def initialize(player, dealer)
    @dealer = dealer
    @player = player
    @bank = Bank.new
  end
end
