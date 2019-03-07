require_relative '../models/player'

class Dealer < Player
  def initialize(name = 'Dealer')
    super(name)
  end
end
