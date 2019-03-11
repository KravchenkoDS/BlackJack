class Game
  def initialize(player, dealer, interface)
    @interface = interface
    @deck = Deck.new
    @bank = Bank.new
    @croupier = Croupier.new
    @player = player
    @dealer = dealer
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
    @croupier.new_game(@player)
    @croupier.new_game(@dealer)
    @croupier.bet(@bank, @player)
    @croupier.bet(@bank, @dealer)
    first_distribution
  end

  def new_round
    loop do
      @interface.show_cards(@player)

      break if player_turn == :open_cards

      dealer_turn

      break if @dealer.can_take_card? == false && @player.can_take_card? == false
    end
  end

  def player_turn
    user_choice = @interface.user_action
    case user_choice
    when :skip then return :skip
    when :take_card then @player.take_card(@deck) if @player.can_take_card?
    when :open_cards then :open_cards
    else @interface.input_not_correct
    end
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
      @croupier.reward(@bank, winner)
      @interface.show_winner(winner)
    else
      @interface.show_draw
    end
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

  def repeat_game?
    case @interface.play_again
    when 1 then true
    else false
    end
  end
end
