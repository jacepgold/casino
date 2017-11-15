# To Do
# Add money
# Subtract Money

#player.wallet.add_wallet
#player.wallet.sub_wallet
# Win/Lose status need players name ex "Jace's Stats"

require 'colorize'
require 'pry'
require_relative 'player'
require_relative 'dice'


class Craps
  attr_accessor :player, :casino
  def initialize(player, casino)
    @casino = casino
    @dice = Dice.new
    @player = player
    @wallet_amount = player.wallet.amount
    @original_wallet = player.wallet.amount
    puts "----- Let\'s play Craps, #{@player.name}! -----"
    @player.check_amount
    @win_qty = 0
    @loss_qty = 0
    game_menu
  end

  def to_bet
    puts 'How much would you like to bet?'
    print '> '


    @bet = $stdin.gets.strip
    @bet.to_f
  end

  def game_one
    @first_roll = 0
    @roll = 0
    @point = 0

    puts "\n\t------ Game One - The Come Out Roll ------\n"
    puts "How much would you like to bet?"
    print '> '
    @bet = $stdin.gets.strip.to_f

    puts 'Press Enter/Return to Throw the Dice.'.colorize(:light_blue)
    input = $stdin.gets.strip
    @first_roll = @dice.roll

    puts "First Roll = #{@first_roll}."
    if @first_roll == 7 || @first_roll == 11
      puts 'Player wins!'
      puts "You won."
      @wallet_amount += (@bet.to_f * 2)
      puts "You have made $#{@bet.to_f * 2}"

    elsif @first_roll == 2 || @first_roll == 3 || @first_roll == 12
      puts "Player loses."
      puts "House wins."
      @loss_qty  += 1
      @wallet_amount -= (@bets.to_f * 2)
      puts "You have lost $#{@bet.to_f * 2}"
    else
      @point = @first_roll
      puts "The point is #{@point}"
      is_won = false
      game_two
    end
  end


  def game_two
    puts "\n\t----- Game Two - The Point -----\n"
    puts 'Press Enter/Return to Throw the Dice.'.colorize(:light_blue)
    puts "The Point is #{@point}!".colorize(:yellow)
    input = $stdin.gets.strip
    while !@is_won
      @roll = @dice.roll
      if @roll == @point
          puts "Rolled a #{@roll}."
          puts "Player wins!"
          @win_qty += 1
          @wallet_amount += (@bet.to_f * 2)
          puts "You have made $#{@bet.to_f * 2}"
          game_menu
        else
        if @roll == 7
          puts "Rolled a #{@roll}."
          puts "House wins!"
          @loss_qty +=  1
          isWon = true
          @wallet_amount -= (@bet.to_f * 2)
          puts "You have lost $#{@bet.to_f * 2}"
          game_menu
        end
      end
    end
  end


  def instructions
    puts "\n\n\t-------------- CRAPS INSTRUCTIONS --------------\n".colorize(:yellow)
    puts "Craps consists of two games... On both games:"
    puts "Player enteres amount to bet. If the user wins, every dollar is doubled."
    puts "If the player loses, every penny bet now belongs to the house."
    puts "\nThe first game is called The Come Out Roll."

    puts "In The Come Out Roll, the odds are in favor of the player."
    puts "If the player rolls a 7 or an 11, the player wins."
    puts "If the player rolls a 2, 3, or 12, the player loses"
    puts "\nIf 1, 4, 5, 6, 8, 9, or 10 are rolled, the game proceeds to the next game."

    puts "\nThe next game is called The Point."
    puts "If the user did not roll 7, 11, 2, 3, or 12, the number rolled"
    puts "becomes The Point...\m"

    puts "In game two, the user cannot lose the game unless rolling a 7."
    puts "However, the player will not win unless rolling The Point."
    puts "Once the game is finished, it will restart to Game 1 until the cycle is broken."
    puts "\n\nPress enter/return to continue..."
    $stdin.gets
    game_menu
  end

  def user_stats
    puts "\n\nUser Win/Lose Stats"
    puts "Wins: #{@win_qty}.".colorize(:green)
    puts "Losses: #{@loss_qty}.".colorize(:red)
    puts "Money in wallet: #{@wallet_amount}".colorize(:green)
    if @wallet_amount < @original_wallet
      puts "You started playing with #{@original_wallet}."
      total_loss = @original_wallet - @wallet_amount
      puts "You have lost #{total_loss}.".colorize(:red)
    elsif @wallet_amount > @original_wallet
      puts "You started playing with #{@original_wallet}."
      total_gain = @wallet_amount
      puts "You have made #{total_gain}.".colorize(:green)
    else
      puts "You have come out even.".colorize(:light_blue)
    end
    game_menu
  end


  def game_menu
  puts '[1] To Play the game, press 1'
  puts '[2] To View player stats, press 2'
  puts '[3] To view the Instructions, press 3'
  puts '[4] To Exit the game, press 4'
  print '> '
  selection = $stdin.gets.to_i

  case selection
    when 1
      game_one
    when 2
      user_stats
    when 3
      instructions
    when 4
      @player.wallet.amount = @wallet_amount
      @casino.menu
    else
      puts 'Invalid user input. Please try again.'
      game_menu
    end
  end
end
