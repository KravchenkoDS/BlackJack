require_relative '../common/game_rules'
class GameMenu
  def game_start_message
    puts GameRules::GAME_START
  end

  def game_end_message
    puts GameRules::GAME_END
  end

  def input_user_name
    puts GameRules::INPUT_PLAYER_NAME
    gets.chomp.to_s.capitalize!
  end

  def input_not_correct
    puts 'Некорректный значение ввода'
  end

  def show_cards(player)
    puts "Игрок: #{player.name}. Количество очков: #{player.hand.points}"
    (player.cards.map { |card| "Карта: #{card.rank}#{card.suit}" }).join(' ')
  end

  def show_money(player)
    puts "Количества денег у '#{player.name}' -- #{player.money}"
  end

  def user_action
    puts GameRules::ACTIONS_MENU
    gets.to_i
  end

  def play_again
    puts GameRules::REPEAT_GAME
    gets.to_i
  end
end
