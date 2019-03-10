require_relative '../models/player'
require_relative '../models/dealer'

class Bank
  attr_accessor :money
  attr_reader :amount, :bet

  def initialize
    new_game
  end

  def make_bets(player, dealer)
    get_money(player, player.bank.bet)
    get_money(dealer, dealer.bank.bet)

    @amount += player.bank.bet
    @amount += dealer.bank.bet
  end

  def now_start_amount(player, dealer)
    player.bank.money += GameRules::STARTING_MONEY
    dealer.bank.money += GameRules::STARTING_MONEY
  end

  def rewarding(winner)
    add_money(winner, @amount)
  end

  def add_money(player, money)
    player.bank.money += money
  end

  def get_money(player, money)
    return GameRules::NO_MONEY if player.bank.money - money < 0

    player.bank.money -= money
  end

  protected

  def new_game
    @amount = 0
    @money = 0
    @bet = GameRules::BET
  end
end
