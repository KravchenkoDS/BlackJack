require_relative 'models/card'
require_relative 'models/player'
require_relative 'models/bank'
require_relative 'models/dealer'
require_relative 'models/deck'
require_relative 'models/game'
require_relative 'models/hand'
require_relative 'models/accountant'
require_relative 'menu/game_menu'

class Main
  def initialize
    @interface = GameMenu.new
  end

  def start
    @interface.game_start_message
    @player = Player.new(@interface.input_user_name)
    @dealer = Dealer.new
    loop do
      game = Game.new(@player, @dealer, @interface)
      game.run
      @interface.show_message(GameMenu::NOT_ENOUGH_MONEY) if @player.bank.empty? || @dealer.bank.empty?
      break unless game.repeat_game?
    end
    @interface.game_end_message
  end
end

main = Main.new
main.start
