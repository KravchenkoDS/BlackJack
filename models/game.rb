require_relative '../models/card'
require_relative '../models/player'
require_relative '../models/bank'
require_relative '../models/dealer'
require_relative '../models/deck'
require_relative '../models/hand'
require_relative '../menu/game_menu'
require_relative '../common/game_rules'

class Game
  def initialize(player, dealer, interface)
    @interface = interface
    @deck = Deck.new
    @player = player
    @dealer = dealer
    @bank = Bank.new
  end

  def new_game
    initial_round
    new_round
    totals_game
    show_result_game
  end

  def initial_round
    @player.reset
    @dealer.reset
    @bank.set_start_amount(@player, @dealer)
    @bank.make_bets(@player, @dealer)
    first_distribution
  end

  def new_round
    loop do
      puts @interface.show_cards(@player)

      break if player_turn

      dealer_turn
      break if @dealer.hand.cards.size == GameRules::MAX_CARDS && @player.hand.cards.size == GameRules::MAX_CARDS
    end
  end

  def player_turn
    user_choice = @interface.user_action
    case user_choice
    when :skip then return false
    when :take_card then @player.take_card(@deck) if @player.can_take_card
    when :open_cards then true
    else @interface.input_not_correct
    end
  end

  def dealer_turn
    @dealer.take_card(@deck) if @dealer.can_take_card
  end

  def first_distribution
    GameRules::BASIC_CARDS.times { @player.take_card(@deck) }
    GameRules::BASIC_CARDS.times { @dealer.take_card(@deck) }
  end

  def totals_game
    winner = define_winner
    if winner
      @bank.rewarding(winner)
      @interface.show_winner(winner)
    else
      @interface.show_draw
    end
  end

  def define_winner
    return if @dealer.points > GameRules::MAX_POINTS && @player.points > GameRules::MAX_POINTS
    return if @dealer.points == @player.points
    return @player if @dealer.points > GameRules::MAX_POINTS
    return @dealer if @player.points > GameRules::MAX_POINTS

    [@player, @dealer].max_by(&:points)
  end

  def show_result_game
    @interface.show_cards(@player)
    @interface.show_money(@player)
    @interface.show_cards(@dealer)
    @interface.show_money(@dealer)
  end

  def repeat_game?
    case @interface.play_again
    when 1 then true
    else false
    end
  end
end
