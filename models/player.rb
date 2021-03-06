class Player
  attr_accessor :name
  attr_reader :hand, :bank

  def initialize(name)
    @name = name
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

  def can_take_card?
    cards.size < GameRules::MAX_CARDS
  end

  def over?
    @hand.points > GameRules::MAX_POINTS
  end
end
