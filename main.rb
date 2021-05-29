# frozen_string_literal: true

require_relative 'control'
require_relative 'players'
require_relative 'user'
require_relative 'dealer'

# Main Class

class Main

  def initialize
    self.start
  end

  def start
    puts 'Введите свое имя:'
    name = gets.chomp
    user = User.new(name)
    dealer = Dealer.new
    control = Control.new(user, dealer)
  end


end

Main.new