# frozen_string_literal: true

# Control Class
class Control

  attr_accessor :bank

  def initialize(user, dealer)
    @user = user
    @dealer = dealer
    @bank = 0
    start_game
  end

  def start_game
    bet_to_round
    
    @user.refresh
    @dealer.refresh
    @user.deal_cards
    @dealer.deal_cards
    user_menu
  end


  def bet_to_round
    @user.amount -= 10
    @dealer.amount -= 10
    @bank += 20
  end

  def user_menu
    loop do
      puts '1. Пропустить'
      puts '2. Открыть карты'
      puts '3. Добавить карту' if @user.cards.length < 3
      input = gets.to_i
      break unless [1, 2, 3].include?(input)
      case input
      when 1
        @dealer.dealer_control
        result_round if @user.cards.length == 3 && @dealer.cards.length == 3
      when 2
        result_round
      when 3
        @user.add_card
        result_round if @user.cards.length == 3 && @dealer.cards.length == 3
      end
    end
    
  end

  def user_statistic
    @user.show_cards(:user)

  end
  def dealer_statistic
    @dealer.show_cards(:dealer)
  end

  def result_round
    user_statistic
    puts "Очки #{@user.name}: #{@user.points}"
    dealer_statistic
    puts "Очки Дилера: #{@dealer.points}"
    calculate
    new_round
  end

  def calculate
    if @user.points > 21
      puts "#{@user.name} проиграл"
      @dealer.amount += bank
    elsif @user.points == @dealer.points
      puts 'Ничья'
      @user.amount += bank / 2
      @dealer.amount += bank / 2
    elsif winner_result?(@user.points, @dealer.points)
      puts "#{@user.name} выиграл"
      @user.amount += bank
    elsif !winner_result?(@user.points, @dealer.points)
      puts "#{@user.name} проиграл"
      @dealer.amount += bank
    end
    puts "текущий баланс #{@user.name}: #{@user.amount}"
    puts "текущий баланс дилера: #{@dealer.amount}"
    puts winner_result?(@user.points, @dealer.points)
  end

  def winner_result?(user, dealer)
    false if dealer > user && dealer <= 21
    true if user > dealer && user <= 21
    
  end

  def new_round
    loop do
      puts '1. Начать заново'
      puts '2. Выход'
      input = gets.to_i
      break unless [1, 2].include?(input)
      case input
      when 1
        @bank = 0
        start_game
      when 2
        abort
      end
      break
    end
    
  end
end