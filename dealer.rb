# frozen_string_literal: true

# Dealer Class

class Dealer < Players

  def initialize
  super()
  end

  def deal_cards
    super()
    dealer_card_info
  end

  def add_card
    super()
    dealer_card_info
  end

  def dealer_card_info
    cards = []
    placeholder = ''
    @cards.each do |key, value|
      cards << key
      summ_points(value)
      placeholder += '*'
    end
    puts "Карты диллера: #{placeholder}"
  end

  def dealer_control
    puts 'Диллер пропускает ход' if points > 17
    add_card if points < 17 && @cards.length < 3
  end
end

