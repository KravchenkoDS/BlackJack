require_relative 'models/card'
require_relative 'models/player'
require_relative 'models/bank'
require_relative 'models/dealer'
require_relative 'menu/game_menu'

class Main
  include GameMenu

  def start
    game_start_message
    @dealer = Dealer.new
    @player = Player.new(input_user_name)
    loop do
      game = Deck.new(@player, @dealer)
      game.run
    end
    game_end_message
  end
end

main = Main.new
main.start
