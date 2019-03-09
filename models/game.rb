require_relative '../models/card'
require_relative '../models/player'
require_relative '../models/bank'
require_relative '../models/dealer'
require_relative '../models/deck'

class Game
  def initialize(_player, _dealer, interface)
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new(input_user_name)
    @bank = Bank.new(@player, @dealer)
    @interface = interface
  end

  def initial_round
    @player.reset
    @dealer.reset
    first_distribution
  end

  def new_round
    loop do
      puts @interface.show_cards(@player)
      case player_turn
      when :take_card then @player.give_card(@deck) if @player.can_take_card
      when :open_cards then break
      end
      dealer_turn
      break if @dealer.cards.size == GameRules::MAX_CARDS && @player.cards.size == GameRules::MAX_CARDS
    end
  end

  def player_turn
    user_choice = @interface.user_action
    case user_choice
    when 1 then return :skip
    when 2 then return :take_card
    when 3 then return :open_cards
    else @interface.input_not_correct
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
    @interface.show_cards(@player)
    @interface.show_money(@player)
    @interface.show_cards(@dealer)
    @interface.show_money(@dealer)
  end

  def repeat_game?
    case play_again?
    when 1 then true
    else false
    end
  end
end
