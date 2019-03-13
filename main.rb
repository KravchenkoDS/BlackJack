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
  def start
    loop do
      game = Game.new.run
      break unless game.repeat_game?
    end
  end
end

main = Main.new
main.start
