class Player
  attr_accessor :name, :money
  attr_reader :cards, :points

  STARTING_MONEY = 100
  NO_MONEY = 'Нет денег'.freeze
  BET = 10
  MAX_CARDS = 3

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
    @cards = []
    @points = 0
  end

  def give_card(deck)
    @cards << deck.give_card
    count_points
  end

  def can_take_card?
    @cards.size < MAX_CARDS
  end

  private

  def count_points
    @cards.each do |card|
      @points += card.point
    end
    if @points >= MAX_POINTS
      @cards.each do |card|
        @points -= 1 if card.ace?
      end
    end
  end
end
