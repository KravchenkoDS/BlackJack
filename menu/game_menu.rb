require_relative '../common/game_rules'
class GameMenu
  GAME_START = 'Приветствую тебя в игре BlackJack'.freeze
  INPUT_PLAYER_NAME = 'Введите Ваше имя'.freeze
  GAME_END = 'Игра окончена!'.freeze
  NO_MONEY = 'Нет денег'.freeze
  REPEAT_GAME = 'Для повтора игры нажмите - 1. Либо любую другую для выхода'.freeze
  DRAW = 'Ничья!'.freeze

  ACTIONS_MENU = [
    '1 - Пропустить ход',
    '2 - Добавить карту',
    '3 - Открыть карты',
    '4 - Прервать игру'
  ].freeze

  # rubocop:disable Style/MutableConstant, Style/SymbolArray
  ACTIONS = [:skip, :take_card, :open_cards, :break_game]
  # rubocop:enable Style/MutableConstant, Style/SymbolArray

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
    puts "Количество денег у '#{player.name}' -- #{player.bank.amount}"
  end

  def user_action
    puts ACTIONS_MENU
    gets.to_i
  end

  def play_again
    puts REPEAT_GAME
    gets.to_i == 1
  end

  def show_result(player)
    winner(player) unless player.nil?
    draw if player.nil?
  end

  def show_message(message)
    puts message
  end

  private

  def draw
    puts DRAW
  end

  def winner(player)
    puts "Победитель #{player.name}" unless player.nil?
  end
end
