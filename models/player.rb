class Player
  attr_accessor :name, :money

  STARTING_MONEY = 100
  NO_MONEY = 'Нет денег'.freeze
  BET = 10

  def initialize(name)
    @name = name
    @money = STARTING_MONEY
    reset
  end

  def bet
    return NO_MONEY if @money - BET < 0

    @money -= BET
    BET
  end

  def reset
    @points = 0
  end
end
