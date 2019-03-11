require_relative '../models/player'
require_relative '../models/dealer'
require_relative '../menu/game_menu'

class Bank
  # attr_accessor :money
  attr_reader :amount

  def initialize
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
    @amount = GameRules::STARTING_MONEY
  end
end
