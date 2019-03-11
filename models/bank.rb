require_relative '../models/player'
require_relative '../models/dealer'
require_relative '../menu/game_menu'

class Bank
  attr_accessor :money
  attr_reader :amount, :bet

  def initialize
    new_game
  end

  def initialize_amount
    @amount = GameRules::STARTING_MONEY
  end

  def withdraw_amount(amount)
    raise GameMenu::NOT_ENOUGH_MONEY if @amount - amount < 0

    @amount -= amount
  end

  def add_amount(amount)
    @amount += amount
  end

  def reset
    @amount = 0
  end

=begin
  def make_bets(player, dealer)
    get_money(player, player.bank.bet)
    get_money(dealer, dealer.bank.bet)

    @amount += player.bank.bet
    @amount += dealer.bank.bet
  end

  def now_start_amount(player, dealer)
    new_game
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
    return GameMenu::NO_MONEY if player.bank.money - money < 0

    player.bank.money -= money
  end
=end

  protected

  def new_game
    @amount = 0
    @money = 0
    @bet = GameRules::BET
  end
end
