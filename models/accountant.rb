class Accountant
  def new_game(player)
    player.bank.reset
    initial_amount(player)
  end

  def refund(game_bank, *players)
    refund_amount = game_bank.amount / players.size
    players.each { |player| player.bank.add_amount(refund_amount) }
    game_bank.reset
  end

  def reward(game_bank, winner)
    winner.bank.add_amount(game_bank.amount)
    game_bank.reset
  end

  def bet(game_bank, *players)
    game_bank.add_amount(GameRules::BET * players.size) if players.each { |player| player.bank.withdraw_amount(GameRules::BET) }
  end

  private

  def initial_amount(player)
    player.bank.add_amount(GameRules::STARTING_MONEY)
  end
end
