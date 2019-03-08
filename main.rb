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

  WIN_PLAYER = 1
  WIN_DEALER = 2
  DRAW = 3

  def start
    game_start_message
    initial_game
    loop do
      initial_round
      new_round
      totals_game
      show_rezult_game
    end
    game_end_message
  end

  def initial_game
    @dealer = Dealer.new
    @player = Player.new(input_user_name)
  end

  def initial_round
    @deck = Deck.new
    @player.reset
    @dealer.reset
    @bank = Bank.new(@player, @dealer)
    first_distribution
  end

  def new_round
    puts show_cards(@player)
    loop do
      user_choice = player_turn
      break if user_choice

      dealer_turn
      break if @dealer.cards.size == MAX_CARDS && @player.cards.size == MAX_CARDS
    end
  end

  def player_turn
    user_choice = user_action
    case user_choice
    when 1 then return false
    when 2 then @player.give_card(@deck) if @player.can_take_card?
    when 3 then return true
    else input_not_correct
    end
    puts show_cards(@player)
  end

  def dealer_turn
    @dealer.give_card(@deck) if @dealer.can_take_card?
  end

  def first_distribution
    BASIC_CARDS.times { @player.give_card(@deck) }
    BASIC_CARDS.times { @dealer.give_card(@deck) }
  end

  def totals_game
    winner = define_winner
    case winner
    when WIN_DEALER then puts 'Вы програли!'
    when WIN_PLAYER then puts 'Вы выграли!'
    else puts'Ничья!'
    end
  end

  def define_winner
    return DRAW if @player.over? && @dealer.over?
    return DRAW if @player.points == @dealer.points
    return WIN_DEALER @dealer if @player.over?
    return WIN_PLAYER @player if @dealer.over?
  end

  def who_winner
    winner = [@player, @dealer].max_by(&:points)
    winner.money = @bank.amount
  end

  def show_rezult_game
    who_winner
    show_cards(@player)
    show_money(@player)
    show_cards(@dealer)
    show_money(@dealer)
  end
end

main = Main.new
main.start
