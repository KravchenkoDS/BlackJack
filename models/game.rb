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
    loop do
      show_draw; break if initial_round == GameMenu::DRAW

      new_round
      totals_game
    end
  end

  def initial_round
    @accountant.bet(@bank, @player, @dealer)
  rescue
    GameMenu::DRAW
  else
    first_distribution
  end

  def new_round
    @interface.show_cards(@player)

    return if player_turn == :open_cards

    dealer_turn

    return if !@dealer.can_take_card? && !@player.can_take_card?
  end

  def show_draw
    @interface.show_message("У #{@player.name} #{GameMenu::NOT_ENOUGH_MONEY}") if @player.bank.empty?
    @interface.show_message("У #{@dealer.name} #{GameMenu::NOT_ENOUGH_MONEY}") if @dealer.bank.empty?

    totals_game if @player.bank.empty? || @dealer.bank.empty?
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
    if winner
      @accountant.reward(@bank, winner)
      @interface.show_winner(winner)
    else
      @interface.show_draw
      @accountant.refund(@bank, @player, @dealer)
    end
    show_result_game
    clear_hands
  end

  def define_winner
    return if @dealer.over? && @player.over?
    return if @dealer.points == @player.points
    return @player if @dealer.over?
    return @dealer if @player.over?

    [@player, @dealer].max_by(&:points)
  end

  def show_result_game
    @interface.show_cards(@player)
    @interface.show_money(@player)
    @interface.show_cards(@dealer)
    @interface.show_money(@dealer)
  end

  def clear_hands
    @player.reset
    @dealer.reset
  end

  def repeat_game?
    @interface.play_again
  end
end
