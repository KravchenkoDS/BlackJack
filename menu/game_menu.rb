class GameMenu
  GAME_START = 'Приветствую тебя в игре BlackJack'.freeze
  INPUT_PLAYER_NAME = 'Введите Ваше имя'.freeze
  GAME_END = 'Игра окончена!'.freeze

  SKIP_CARDS = 1
  ADD_CARD = 2
  OPEN_CARDS = 3

  ACTIONS_MENU = [
    '1 - Пропустить ход',
    '2 - Добавить карту',
    '3 - Открыть карты'
  ].freeze

  REPEAT_GAME = 'Для повтора игры нажмите - 1. Либо любую другую для выхода'.freeze

  def game_start_message
    puts GAME_START
  end

  def game_end_message
    puts GAME_END
  end

  def input_user_name
    puts INPUT_PLAYER_NAME
    gets.chomp.to_s.capitalize!
  end

  def input_not_correct
    puts 'Некорректный значение ввода'
  end

  def show_cards(player)
    puts "Игрок: #{player.name}. Количество очков: #{player.points}"
    (player.cards.map { |card| "Карта: #{card.rank}#{card.suit}" }).join(' ')
  end

  def show_money(player)
    puts "Количества денег у '#{player.name}' -- #{player.money}"
  end

  def user_action
    puts ACTIONS_MENU
    gets.to_i
  end

  def play_again?
    puts REPEAT_GAME
    gets.to_i
  end
end
