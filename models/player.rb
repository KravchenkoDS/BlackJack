class Player
  attr_accessor :name
  attr_reader :money, :hand, :bank

  def initialize(name)
    @name = name
    @money = 0
    @hand = Hand.new
    @bank = Bank.new
    reset
  end

  def take_card(deck)
    @hand.give_card(deck)
  end

  def cards
    @hand.cards
  end

  def points
    @hand.points
  end

  def reset
    @hand.reset
  end

  def can_take_card
    cards.size < GameRules::MAX_CARDS
  end

  def over?
    @hand.points > GameRules::MAX_POINTS
  end

  #   def bet
  #     return GameRules::NO_MONEY if @money - GameRules::BET < 0
  #
  #     @money -= GameRules::BET
  #     GameRules::BET
  #   end

  # def add_money(value)
  #   @money += value
  # end
end
