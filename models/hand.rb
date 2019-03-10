require_relative '../models/card'
require_relative '../models/deck'
require_relative '../menu/game_menu'

class Hand
  attr_reader :cards, :points

  def initialize
    @cards = []
    @points = 0
  end

  def reset
    @cards = []
    @points = 0
  end

  def give_card(deck)
    @cards << deck.give_card
    count_points
  end

  private

  def count_points
    @points = 0
    @cards.each do |card|
      @points += card.point
      @points -= GameRules::MIN_VALUE_ACE if card.ace? && @points > MAX_POINTS
    end
  end
end
