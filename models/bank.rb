class Bank
  attr_reader :amount, bet

  def initialize
    new_game
  end

  def make_bets(player, dealer)
    @amount += player.bank.bet
    @amount += dealer.bank.bet
  end

  def set_start_amount(player, dealer)
    player.money += GameRules::STARTING_MONEY
    dealer.money += GameRules::STARTING_MONEY
  end

  def add_money(player, dealer)
    player.money += player.bank.bet
    dealer.money += dealer.bank.bet
  end

  def rewarding(winner)
    winner.add_money(@amount)
  end

  protected

  def new_game
    @amount = 0
    @bet = GameRules::BET
  end
end
