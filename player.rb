require_relative 'wallet'

class Player
  MIN_AGE = 21
  attr_accessor :name, :age, :wallet
  def initialize()
    puts "Please enter name:".cyan
    print '> '
    @name = gets.strip
    puts "Please enter age:".cyan
    print '> '
    @age = gets.to_i
    age_verification()
    puts "How much money are you playing with?".cyan
    print '> '
    amount = gets.to_f
    @wallet = Wallet.new(amount)
  end

  def age_verification()
    if @age < MIN_AGE
      puts "Get out of here!".red
      exit 0
    end
  end

  def check_amount()
    puts @wallet.amount === 0 ? "You have no money! GO HOME!".red : "You have money!".cyan
  end

end
