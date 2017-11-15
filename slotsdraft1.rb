require 'pry'
require 'colorize'
require_relative 'player'

class Slots
  attr_accessor :player
  def initialize(player, casino)
    @player = player
    @casino = casino
    slots
  end

  def slots

    slotList = [
      "\u{1F378}",
      "\u{1F347}",
      "\u{1F36d}",
      "\u{1F3B0}",
      "\u{1F308}"
    ]

    winningslots = []
    slots1 = slotList.sample
    winningslots << slots1
    slots2 = slotList.sample
    winningslots << slots2
    slots3 = slotList.sample
    winningslots << slots3


    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$".green
    puts "***** ~ WELCOME TO SLOTS ~ *****".yellow
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$".green
    puts 'Would you like to spin?'.yellow
    puts '1) Spin ($1)'.yellow
    puts '2) Exit'.yellow
    response = gets.to_i

    case response
    when 1
      @player.wallet.sub_wallet(1)
      sleep(1)
      print winningslots[0] + "   "
      sleep(1)
      print winningslots[1] + "   "
      sleep(1)
      print winningslots[2]
      puts " "
      if winningslots[0] == winningslots[1] && winningslots[0] == winningslots[2]
        puts "$$$$$$$$$$$$$$$$$$$".green
        puts "$ $ JACKPOT!!!! $ $".green
        puts "$$$$$$$$$$$$$$$$$$$".green
        @player.wallet.add_wallet(100)
        puts "#{@player.name} has $#{@player.wallet.amount}"
      elsif
        winningslots[0] == winningslots[1]
        puts "======================".green
        puts "| $ YOU GOT A PAIR $ |".green
        puts "======================".green
        @player.wallet.add_wallet(25)
        puts "#{@player.name} has $#{@player.wallet.amount}"
      elsif
        winningslots[1] == winningslots[2]
        puts "======================".green
        puts "| $ YOU GOT A PAIR $ |".green
        puts "======================".green
        @player.wallet.add_wallet(25)
        puts "#{@player.name} has $#{@player.wallet.amount}"
      else
        puts "=============".red
        puts "| ! LOSER ! |".red
        puts "=============".red
        puts "#{@player.name} has $#{@player.wallet.amount}"
      end
    when 2
      @casino.menu
    else
      puts "invalid choice"
      puts "please answer"
      response2 = gets.to_i
    end

    spin_again

  end

  def spin_again

    puts "Would you like to play again?".yellow
    puts "1) Yes".yellow
    puts "2) Exit".yellow
    response2 = gets.to_i

    case response2
    when 1
      slots
    when 2
      @casino.menu
    else
      puts "Invalid Choice"
      puts "Please Try Again"
      response2 = gets.to_i
    end

  end

end
