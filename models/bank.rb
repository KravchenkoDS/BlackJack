class Bank
  attr_reader :amount

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
    new_game
  end

  def bet
    @amount += @player.bet
    @amount += @dealer.bet
    puts @amount
  end

  protected

  def new_game
    @amount = 0
  end
end
