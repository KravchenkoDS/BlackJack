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
      initial_round
      new_round
      totals_game
      show_result_game
      break unless repeat_game?
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
    loop do
      puts show_cards(@player)
      case player_turn
      when :take_card then @player.give_card(@deck) if @player.can_take_card
      when :open_cards then break
      end
      dealer_turn
      break if @dealer.cards.size == GameRules::MAX_CARDS && @player.cards.size == GameRules::MAX_CARDS
    end
  end

  def player_turn
    user_choice = user_action
    case user_choice
    when 1 then return :skip
    when 2 then return :take_card
    when 3 then return :open_cards
    else input_not_correct
    end
  end

  def dealer_turn
    @dealer.give_card(@deck) if @dealer.can_take_card
  end

  def first_distribution
    GameRules::BASIC_CARDS.times { @player.give_card(@deck) }
    GameRules::BASIC_CARDS.times { @dealer.give_card(@deck) }
  end

  def totals_game
    winner = define_winner
    case winner
    when GameRules::WIN_DEALER then puts 'Вы програли!'
    when GameRules::WIN_PLAYER then puts 'Вы выграли!'
    else puts 'Ничья!'
    end
  end

  def define_winner
    return GameRules::DRAW if @player.over? && @dealer.over?
    return GameRules::DRAW if @player.points == @dealer.points
    return GameRules::WIN_DEALER if @player.over? || @dealer == winner_on_points
    return GameRules::WIN_PLAYER if @dealer.over? || @player == winner_on_points
  end

  def winner_on_points
    winner = [@player, @dealer].max_by(&:points)
    winner.money = @bank.amount
    winner
  end

  def show_result_game
    show_cards(@player)
    show_money(@player)
    show_cards(@dealer)
    show_money(@dealer)
  end

  def repeat_game?
    case play_again?
    when 1 then true
    else false
    end
  end
end

main = Main.new
main.start
