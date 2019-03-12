require_relative '../models/player'
require_relative '../models/dealer'
require_relative '../menu/game_menu'
require_relative '../common/game_rules'

class Bank
  attr_reader :amount

  def initialize
    @amount = 0
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

  def empty?
    @amount < GameRules::BET
  end
end
