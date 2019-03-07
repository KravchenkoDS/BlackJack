require_relative 'models/card'
require_relative 'models/player'
require_relative 'models/bank'
require_relative 'models/dealer'
require_relative 'models/deck'
require_relative 'menu/game_menu'

class Main
  include GameMenu
  BASIC_CARDS = 2
  MAX_POINTS = 21
  MAX_CARDS = 3

  def start
    game_start_message
    initial_game
    loop do
      @deck = Deck.new
      initial_round
      new_round
    end
    game_end_message
  end

  def initial_game
    @dealer = Dealer.new
    @player = Player.new(input_user_name)
  end

  def initial_round
    @bank = Bank.new(@player, @dealer)
    BASIC_CARDS.times { @player.give_card(@deck) }
    BASIC_CARDS.times { @dealer.give_card(@deck) }
  end

  def new_round
    puts show_cards(@player)
    loop do
      user_choice = user_move
      break if user_choice == true

      dealer_move unless user_choice.nil?
      break if @dealer.cards.size == MAX_CARDS && @player.cards.size == MAX_CARDS
    end
  end

  def user_move
    case user_action
    when SKIP_CARDS then false
    when ADD_CARD then @player.give_card(@deck) if @player.can_take_card?
    when OPEN_CARDS then true
    else input_not_correct
    end
    puts show_cards(@player)
  end

  def dealer_move
    @dealer.give_card(@deck) if @dealer.can_take_card?
  end
end

main = Main.new
main.start
