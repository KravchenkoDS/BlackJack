require_relative '../models/hand'
require_relative '../common/game_rules'

class Player
  attr_accessor :name
  attr_reader :money, :hand

  NO_MONEY = 'Нет денег'.freeze

  def initialize(name)
    @name = name
    @money = GameRules::STARTING_MONEY
    @hand = Hand.new
    reset
  end

  def bet
    return NO_MONEY if @money - GameRules::BET < 0

    @money -= GameRules::BET
    GameRules::BET
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

  def add_money(value)
    @money += value
  end
end
