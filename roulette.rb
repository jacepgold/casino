require 'colorize'
require 'pry'
require_relative 'player'

class Roulette
  attr_accessor :player
  def initialize(player, casino)
    @player = player
    @casino = casino
    @betting_profile = []
    puts `say welcome to roulette`
    roulette_menu()
  end

  def display_roulette()
    (1..36).each do |num|
      print "       #{num.to_s.blue}  " if num.between?(1, 9) && num % 2 === 0
      print "       #{num.to_s.red}  " if num.between?(1, 9) && num % 2 != 0
      print "       #{num.to_s.blue} " if num.between?(10, 36) && num % 2 === 0
      print "       #{num.to_s.red} " if num.between?(10, 36) && num % 2 != 0
      puts "\n".ljust(1) if num % 3 === 0
    end
  end

  def roulette_menu()
    puts "===================================".yellow
    puts "***** ~ WELCOME TO ROULETTE ~ *****".yellow
    puts "===================================".yellow
    display_roulette()
    @player.check_amount()
    puts "#{@player.name} has $#{@player.wallet.amount}".cyan
    menu_options = [
      "Rules -- Please Read First",
      "View Betting Profile",
      "Bet Outside",
      "Bet Inside",
      "Spin the Wheel!",
      "Back to Casino"
    ]
    menu_options.each_with_index { |opt, i| puts "[#{i + 1}] #{opt}" }
    print "> "
    action = gets.strip.to_i
    case action
      when 1
        roulette_rules()
      when 2
        betting_profile()
      when 3
        bet_outside()
      when 4
        bet_inside()
      when 5
        spin_wheel(@bet, @bet_row, @bet_pair, @bet_single)
      when 6
        @casino.menu
      else
        puts "Invalid Input -- Please Try Again"
        roulette_menu()
    end
    roulette_menu()
  end

  def roulette_rules()
    puts "======================".yellow
    puts "| Outside Bets - $10 |".yellow
    puts "======================".yellow
    outside_1_1 = ["EVEN", "ODD", "RED", "BLUE", "1-18", "19-36"]
    puts "1:1 payout:".upcase
    outside_1_1.each { |bet| puts "* #{bet}" }
    outside_2_1 = ["1-12", "12-24", "24-36"]
    puts "2:1 payout:".upcase
    outside_2_1.each { |bet| puts "* #{bet}" }
    puts "===============".yellow
    puts "| Inside Bets |".yellow
    puts "===============".yellow
    inside_bets = ["Pick a single, 35:1 PAYOUT", "Pick a pair, 17:1 PAYOUT", "Pick a row, 11:1 PAYOUT"]
    inside_bets.each { |bet| puts "* #{bet}" }
    puts "Press [enter] to continue!".cyan
    action = gets.strip
    if action == ""
      roulette_menu()
    end
  end

  def betting_profile()
    puts "===================".yellow
    puts "| Betting Profile |".yellow
    puts "===================".yellow
    @betting_profile.each_with_index { |bet, i| puts "[#{i + 1}] #{bet}" }
    puts "Press [enter] to continue."
    print "> "
    gets.strip
  end

  def bet_inside()

    pairs = [[1, 2], [2, 3], [4, 5], [5, 6], [7, 8], [8, 9], [10, 11], [11, 12],
      [13, 14], [14, 15], [16, 17], [17,18], [19, 20], [20, 21], [22, 23], [23, 24],
      [25, 26], [26, 27], [28, 29], [29, 30], [31, 32], [32, 33], [34, 35], [35, 36]]
    rows =[[1, 2, 3], [4, 5, 6], [7, 8, 9], [10, 11, 12], [13, 14, 15], [16, 17, 18],
      [19, 20, 21], [22, 23, 24], [25, 26, 27], [28, 29, 30], [31, 32, 33], [34, 35, 36]]

    puts "You can put down whatever amount you want on an inside bet!".red
    inside_bets = ["Pick a single, 35:1 PAYOUT", "Pick a pair, 17:1 PAYOUT", "Pick a row, 11:1 PAYOUT"]
    inside_bets.each_with_index { |bet, i| puts "[#{i + 1}] #{bet}" }
    puts "Which inside bet would you like to make? Press [4] to return.".blue
    print "> "
    choice = gets.to_i
    case choice
      when 1
        single = []
        puts "Pick a single -- will only accept first number"
        print "> "
        single << gets.to_i
        puts "How much?"
        print "> "
        @bet_single = gets.to_i
        check_bet(single, @bet_single)
      when 2
        pairs.each_with_index { |pair, i| puts "(#{i + 1}) #{pair}" }
        puts "Pick a pair!"
        print "> "
        @pair = pairs[gets.to_i - 1]
        puts "How much?"
        print "> "
        @bet_pair = gets.to_i
        check_bet(@pair, @bet_pair)
      when 3
        rows.each_with_index { |row, i| puts "(#{i + 1}) #{row}" }
        puts "Pick a row!"
        print "> "
        @row = rows[gets.to_i - 1]
        puts "How much?"
        print "> "
        @bet_row = gets.to_i
        check_bet(@row, @bet_row)
      when 4
        roulette_menu
      else
        "Invalid Input -- Please Try Again!"
        bet_inside()
    end
  end

  def bet_outside()
    @bet = 10
    puts "All outside bets are $10.".red
    puts "Please select [1] 1:1 bets or [2] 2:1 bets. Press [3] to return.".blue
    print "> "
    choice = gets.to_i
    case choice
      when 1
        outside_1_1 = ["EVEN", "ODD", "RED", "BLUE", "1-18", "19-36"]
        outside_1_1.each_with_index { |bet, i| puts "[#{i + 1}] #{bet}" }
        puts "Choose your bet:"
        print "> "
        outside_bet = gets.to_i
        if outside_bet === 5 || outside_bet === 6
          bet_arr = outside_1_1[outside_bet - 1].split("-").map(&:to_i)
          bet_range = (bet_arr[0]..bet_arr[1])
          check_bet(bet_range, @bet)
        else
          check_bet(outside_1_1[outside_bet - 1], @bet)
        end
      when 2
        outside_2_1 = ["1-12", "12-24", "24-36"]
        outside_2_1.each_with_index { |bet, i| puts "[#{i + 1}] #{bet}" }
        puts "Choose your bet:"
        print "> "
        bet_arr = outside_2_1[gets.to_i - 1].split("-").map(&:to_i)
        bet_range = (bet_arr[0]..bet_arr[1])
        check_bet(bet_range, @bet)
      when 3
        roulette_menu()
      else
        "Invalid Input -- Please Try Again!"
        bet_outside()
      end
  end

  def spin_wheel(bet = 0, bet_row = 0, bet_pair = 0, bet_single = 0)
    puts "=====================".yellow
    puts "| Bets on the Table |".yellow
    puts "=====================".yellow
    @betting_profile.each_with_index { |bet, i| puts "[#{i + 1}] #{bet}" }
    puts "==========================".yellow
    puts "| $ SPINNING THE WHEEL $ |".yellow
    puts "==========================".yellow
    sleep(1)
    single_num = rand(1..36)
    sleep(1)
    puts "The winning number is".cyan + " " + "| ".light_blue + single_num.to_s.light_blue + " |".light_blue
    sleep(1)
    @betting_profile.each do |bet|
      if bet.is_a? String
        if single_num % 2 === 0 && bet == "EVEN" || bet == "BLUE"
          puts "You picked even or blue! Woohoo!".blue
          @player.wallet.add_wallet(@bet * 2)
        elsif single_num % 2 != 0 && bet == "ODD" || bet == "RED"
          puts "You picked odd or red! Woohoo!".red
          @player.wallet.add_wallet(@bet * 2)
        else
          puts "...no dice!".red
        end
      else bet.is_a? Array || Range
        if bet.include?(single_num) && bet.size === 2
          puts "You picked a pair correctly!".cyan
          @player.wallet.add_wallet(@bet_pair + (@bet_pair * 17))
        elsif bet.include?(single_num) && bet.size === 3
          puts "You picked a row correctly!".cyan
          @player.wallet.add_wallet(@bet_row + (@bet_row * 11))
        elsif bet.include?(single_num) && bet.size === 12
          puts "You picked a 12-number range correctly!".cyan
          @player.wallet.add_wallet(@bet + (@bet * 2))
        elsif bet.include?(single_num) && bet.size === 13
          puts "You picked a 12-number range correctly!".cyan
          @player.wallet.add_wallet(@bet + (@bet * 2))
        elsif bet.include?(single_num) && bet.size === 18
          puts "You picked an 18-number range correctly!".cyan
          @player.wallet.add_wallet(@bet * 2)
        elsif bet.include?(single_num) && bet.size === 1
          puts "You picked a single correctly! Hope you bet a lot!".cyan
          @player.wallet.add_wallet(@bet_single + (@bet_single * 35))
          `say ding ding ding`
        else
          puts "...no dice!".red
        end
      end
    end
    @betting_profile = []
    puts "Press [enter] to continue."
    print "> "
    gets.strip
  end

  def check_bet(bet_type, bet_amount)
    if @player.wallet.amount < bet_amount
      puts "You don't have enough money!"
    else
      @player.wallet.sub_wallet(bet_amount)
      @betting_profile << bet_type
    end
  end

end
