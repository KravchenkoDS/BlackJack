class Bank
  attr_reader :amount

  def initialize
    new_game
  end

  protected

  def new_game
    @amount_bet = 0
  end
end
