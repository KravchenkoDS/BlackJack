module GameRules
  GAME_START = 'Приветствую тебя в игре BlackJack'.freeze
  INPUT_PLAYER_NAME = 'Введите Ваше имя'.freeze
  GAME_END = 'Игра окончена!'.freeze
  NO_MONEY = 'Нет денег'.freeze
  REPEAT_GAME = 'Для повтора игры нажмите - 1. Либо любую другую для выхода'.freeze
  DRAW = 'Ничья!'.freeze

  ACTIONS_MENU = [
    '1 - Пропустить ход',
    '2 - Добавить карту',
    '3 - Открыть карты'
  ].freeze

  MAX_POINTS = 21
  MAX_CARDS = 3
  MAX_DEALER_POINTS = 17
  BET = 10
  STARTING_MONEY = 100
  BASIC_CARDS = 2
  MIN_VALUE_ACE = 10 # 11 - 1
end
