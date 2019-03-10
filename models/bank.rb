class Bank
  attr_reader :amount

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    new_game
  end

  def make_bets
    @amount += @player.bet
    @amount += @dealer.bet
  end

  def set_start_amount
    @money += GameRules::STARTING_MONEY
  end

  def rewarding(winner)
    winner.add_money(@bank.amount)
    new_game
  end

  protected

  def new_game
    @amount = 0
    make_bets
  end
end
