require_relative '../common/game_rules'

class Player
  attr_accessor :name, :money
  attr_reader :cards, :points

  NO_MONEY = 'Нет денег'.freeze

  def initialize(name)
    @name = name
    @money = GameRules::STARTING_MONEY
    reset
  end

  def bet
    return NO_MONEY if @money - GameRules::BET < 0

    @money -= GameRules::BET
    GameRules::BET
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
    @cards.size < GameRules::MAX_CARDS
  end

  def over?
    @points > GameRules::MAX_POINTS
  end

  def add_money(value)
    @money += value
  end

  private

  def count_points
    @points = 0
    @cards.each do |card|
      @points += card.point
    end
    if @points >= GameRules::MAX_POINTS
      @cards.each do |card|
        @points -= 1 if card.ace?
      end
    end
  end
end
