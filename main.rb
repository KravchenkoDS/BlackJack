require_relative 'models/card'
require_relative 'models/player'
require_relative 'models/bank'
require_relative 'models/dealer'
require_relative 'models/deck'
require_relative 'models/game'
require_relative 'menu/game_menu'

class Main
  def initialize
    @interface = GameMenu.new
  end

  def start
    game_start_message
    @game = Game.new
    @game.initial_game
    loop do
      game.initial_round
      game.new_round
      game.totals_game
      game.show_result_game
      break unless game.repeat_game?
    end
    game_end_message
  end
end

main = Main.new
main.start
