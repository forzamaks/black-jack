# frozen_string_literal: true

# User Class

class User < Players

  attr_accessor :name

  def initialize(name)
    @name = name
    super()
  end

  def deal_cards
    super()
    user_card_info
    puts "Ставки сделаны текущий баланс: #{amount}"
  end

  def user_card_info
    @points = 0
    show_cards(:user)
    puts "Колличество очков: #{points}"
  end
  def add_card
    super()
    user_card_info
  end

end