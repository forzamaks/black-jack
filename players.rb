# frozen_string_literal: true

# Players Class

class Players

  attr_accessor :amount, :cards, :points, :issused_cards

  CARDS = ['2','3','4','5','6','7','8','9','10','В','Д','К','Т']
  TYPE = ["<>", "<3", "+", "^"]
  @@issused_cards = []

  def initialize
    @amount = 100
    @cards = {}
    @points = 0
  end

  def refresh
    @cards = {}
    @points = 0
  end

  def deal_cards
    2.times do
      number_card = ''
      suit = ''
      loop do
        suit = TYPE.sample
        number_card =  Random.rand(CARDS.length)
        break unless self.issused_cards.include?("#{CARDS[number_card]} #{suit}")
      end
      card = create_card(suit, number_card)
    end
  end

  def create_card(suit, number_card)
    value_card = "#{CARDS[number_card]} #{suit}"
    cards[value_card] = CARDS[number_card]
    @@issused_cards << value_card
  end

  def summ_points(value)
    self.points += 10 if ["В".to_sym, "Д".to_sym, "К".to_sym].include?(value.to_sym)
    self.points += value.to_i unless %w["В".to_sym, "Д".to_sym, "К".to_sym, "Т".to_sym].include?(value.to_sym)
    self.points += 1 if (self.points + 11) > 21 && value == 'Т'
    self.points += 11 if (self.points + 11) < 21 && value == 'Т'
  end

  def add_card
    number_card = ''
    suit = ''
    loop do
      suit = TYPE.sample
      number_card =  Random.rand(CARDS.length)
      break unless self.issused_cards.include?("#{CARDS[number_card]} #{suit}")
    end
    card = create_card(suit, number_card)
  end

  def issused_cards
    @@issused_cards
  end


  def show_cards(player)
    @points = 0
    cards = []
    @cards.each do |key, value|
      cards << key
      summ_points(value)
    end
    puts "Ваши карты: #{cards.join(', ')}" if player == :user
    puts "Карты дилера: #{cards.join(', ')}" if player == :dealer
  end


end

