require_relative '../common/game_rules'
class GameMenu
  GAME_START = 'Приветствую тебя в игре BlackJack'.freeze
  INPUT_PLAYER_NAME = 'Введите Ваше имя'.freeze
  GAME_END = 'Игра окончена!'.freeze
  NO_MONEY = 'Нет денег'.freeze
  REPEAT_GAME = 'Для повтора игры нажмите - 1. Либо любую другую для выхода'.freeze
  DRAW = 'Ничья!'.freeze
  NOT_ENOUGH_MONEY = 'Недостаточно денег'.freeze

  ACTIONS_MENU = [
    '1 - Пропустить ход',
    '2 - Добавить карту',
    '3 - Открыть карты'
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

  def show_money(player)
    puts "Количества денег у '#{player.name}' -- #{player.bank.money}"
  end

  def user_action
    puts ACTIONS_MENU
    case gets.to_i
    when 1 then return :skip
    when 2 then return :take_card
    when 3 then return :open_cards
    else input_not_correct
    end
  end

  def play_again
    puts REPEAT_GAME
    gets.to_i
  end

  def show_winner(winner)
    puts "Победитель #{winner.name}"
  end

  def show_draw
    puts DRAW
  end
end
