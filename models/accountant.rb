class Croupier
  attr_reader :amount

  def initialize
    @amount = 0
  end

  def bet(game_bank, player)
    player.bank.withdraw_amount(GameRules::BET)
    game_bank.add_amount(GameRules::BET)
  end

  def reward(game_bank, winner)
    winner.bank.add_amount(game_bank.amount)
    game_bank.reset
  end
end
