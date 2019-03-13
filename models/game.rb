class Game
  ACTIONS = %i(skip take_card open_cards break_game).freeze
  def initialize(interface)
    @interface = interface
    @player = Player.new(interface.input_user_name)
    @dealer = Dealer.new
    @deck = Deck.new
    @bank = Bank.new
    @accountant = Accountant.new
  end

  def run
    game_preparation
    play_game
    totals_game
    @interface.game_end_message
  end

  def game_preparation
    @interface.game_start_message
    @accountant.new_game(@player)
    @accountant.new_game(@dealer)
  end

  def play_game
    loop do
      break unless can_start_round?

      play_round
      break unless continue?
    end
  end

  def play_round
    return if round_preparation == GameMenu::DRAW

    loop do
      @interface.show_cards(@player)

      return_value = player_turn
      return :open_cards if return_value == :open_cards

      dealer_turn

      return :open_cards if !@dealer.can_take_card? && !@player.can_take_card?
    end
  end

  def round_preparation
    @accountant.bet(@bank, @player, @dealer)
    first_distribution
  rescue
    @interface.exit_with_error
    exit
  end

  #   def round_preparation
  #     @accountant.bet(@bank, @player, @dealer)
  #   rescue
  #     GameMenu::DRAW
  #   else
  #     first_distribution
  #   end

  def can_start_round?
    !@player.bank.empty? && !@dealer.bank.empty?
  end

  def player_turn
    action_index = @interface.user_action - 1
    case ACTIONS[action_index]
    when :take_card then @player.take_card(@deck) if @player.can_take_card?
    end
    ACTIONS[action_index]
  end

  def dealer_turn
    @dealer.take_card(@deck) if @dealer.can_take_card?
  end

  def first_distribution
    GameRules::BASIC_CARDS.times { @player.take_card(@deck) }
    GameRules::BASIC_CARDS.times { @dealer.take_card(@deck) }
  end

  def totals_game
    winner = define_winner
    @accountant.reward(@bank, winner) if winner
    @accountant.refund(@bank, @player, @dealer) if winner.nil?
    show_result_game(winner)
  end

  def define_winner
    return nil if @dealer.points == @player.points

    return @player if @dealer.over?
    return @dealer if @player.over?

    [@player, @dealer].max_by(&:points)
  end

  def show_result_game(winner)
    @interface.show_result(winner)

    @interface.show_cards(@player)
    @interface.show_money(@player)
    @interface.show_cards(@dealer)
    @interface.show_money(@dealer)

    clear_hands
  end

  def clear_hands
    @player.reset
    @dealer.reset
  end

  def repeat_game?
    @interface.play_again
  end

  def continue?
    @interface.continue_round?
  end
end
