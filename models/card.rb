class Card
  attr_reader :suit, :value

  SUITS = %w[♠ ♥ ♣ ♦].freeze
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze

  def initialize(rank, suit, point)
    @rank = rank
    @suit = suit
    @point = point
  end

  def ace?
    @rank == 'A'
  end
end
