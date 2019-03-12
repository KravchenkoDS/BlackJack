class Game
  def initialize(player, dealer, interface)
    @interface = interface
    @deck = Deck.new
    @bank = Bank.new
    @accountant = Accountant.new
    @player = player
    @dealer = dealer
    @accountant.new_game(@player)
    @accountant.new_game(@dealer)
  end

  def run
    play_game
    winner = define_winner
    @interface.show_result(winner)
    totals_game
    @interface.game_end_message
  end

  def initial_round
    @accountant.bet(@bank, @player, @dealer)
  rescue
    GameMenu::DRAW
  else
    first_distribution
  end

  def play_game
    loop do
      break unless can_start_round?

      break if new_round == :break_game || :open_cards || GameMenu::DRAW
    end
  end

  def new_round
    return if initial_round == GameMenu::DRAW

    loop do
      @interface.show_cards(@player)

      return_value = player_turn
      return :open_cards if return_value == :open_cards
      return :break_game if return_value == :break_game

      dealer_turn

      return :open_cards if !@dealer.can_take_card? && !@player.can_take_card?
    end
  end

  def can_start_round?
    !@player.bank.empty? && !@dealer.bank.empty?
  end

  def player_turn
    action_index = @interface.user_action - 1
    case GameMenu::ACTIONS[action_index]
    when :take_card then @player.take_card(@deck) if @player.can_take_card?
    end
    GameMenu::ACTIONS[action_index]
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
    show_result_game
  end

  def define_winner
    return nil if @dealer.points == @player.points

    return @player if @dealer.over?
    return @dealer if @player.over?

    [@player, @dealer].max_by(&:points)
  end

  def show_result_game
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
end
