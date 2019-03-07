require_relative '../models/player'
require_relative '../models/dealer'
require_relative '../models/bank'
require_relative '../models/card'

class Deck
  attr_accessor :deck

  def initialize
    @deck = []
    init_deck
  end

  def init_deck
    Card::SUITS.each do |suit|
      Card::RANKS.each_with_index do |rank, index|
        @deck << Card.new(suit, rank, Card::VALUES[index])
      end
    end
    @deck.shuffle
  end

  def give_card
    @deck.shift
  end
end
