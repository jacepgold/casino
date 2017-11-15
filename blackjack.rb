require_relative 'player'
require 'colorize'
require 'artii'
require 'pry'
require_relative 'wallet'
require_relative 'card'
require_relative 'deck'


class Blackjack
  attr_accessor :player, :deck
  def initialize(player, casino)
    @player = player
    @casino = casino
    @deck = Deck.new
    #@casino = casino
    init_blackjack()
    init_blackjack2()
  end

  def init_blackjack()
    puts "===================================".yellow
    puts "***** ~ WELCOME TO BLACKJACK ~ ****".yellow
    puts "===================================".yellow
#binding.pry
blackjack_menu()
end

def blackjack_menu()
  puts "Rules - Deal, then decide to hit or stay---over 21 is a bust"
  menu_options = ["Deal", "Exit"]
  menu_options.each_with_index { |opt, i| puts "[#{i + 1}] #{opt}" }
  action = gets.strip.to_i
case action
  when 1
    deal()
  when 2
    @casino.menu
  else
    puts "Invalid Input -- Please Try Again"
  end
end

def blackjack_rules()
puts "==========================".yellow
puts "| Deal - $5 per hand |".yellow
puts "==========================".yellow
  end
#binding.pry
# Deal two cards
#binding.pry
def deal()
#binding.pry
  shuffled = @deck.shuffle_cards
  #binding.pry
  dealer_cards = shuffled.shift(2)
  user_cards = shuffled.shift(2)
  #binding.pry
  puts "Dealer hand #{dealer_cards[0].rank} of #{dealer_cards[0].suit} and #{dealer_cards[1].rank} of #{dealer_cards[1].suit}"
  puts "Your hand #{user_cards[0].rank} of #{user_cards[0].suit} and #{user_cards[1].rank} of #{user_cards[1].suit}"

end

def init_blackjack2()
#binding.pry
blackjack_menu2()
end

  def blackjack_menu2()
    puts "Hit or Stay--remember money is riding on this".cyan
    menu_options = ["Hit", "Stay"]
    menu_options.each_with_index { |opt, i| puts "[#{i + 1}] #{opt}"}
    action = gets.strip.to_i
  case action
    when 1
      hit()
    when 2
      @casino.menu
end
end
  def hit()
    shuffled = @deck.shuffle_cards
    dealer_cards = shuffled.pop(1)
    user_cards = shuffled.pop(1)
    puts "Dealer hand #{dealer_cards[0].rank} of #{dealer_cards[0].suit}"
    puts "Your hand #{user_cards[0].rank} of #{user_cards[0].suit}"
    @casino.menu
end
end


# wait for hit or stay
# deal one card
# evaluate whether the combination of cards is above 21
# player = Player.new()
# Blackjack.new(player)
