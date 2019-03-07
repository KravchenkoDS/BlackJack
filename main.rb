require_relative 'models/card'
require_relative 'models/player'
require_relative 'models/bank'
require_relative 'models/dealer'
require_relative 'models/deck'
require_relative 'menu/game_menu'

class Main
  include GameMenu

  def start
    game_start_message
    initial_game
    loop do
      deck = Deck.new
    end
    game_end_message
  end

  def initial_game
    @dealer = Dealer.new
    @player = Player.new(input_user_name)
  end

  def initial_round
    @bank = Bank.new(@player, @dealer)
    @bank.bet #Ставки
  end
end

main = Main.new
main.start
