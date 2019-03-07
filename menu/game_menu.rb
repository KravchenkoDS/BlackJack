module GameMenu
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

  REPEAT_GAME_MENU = [
    'Повторить игру?',
    '1 - Да',
    '2 - Нет'
  ].freeze

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
end
