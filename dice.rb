class Dice
  attr_accessor :sum
  def initialize
    roll
  end

  def roll
    @die1 = 1 + rand(6)
    @die2 = 1 + rand(6)
    @sum = @die1 + @die2
  end

  def show_dice
    print "Die1: ", @die1, " Die2:", @die2
  end

  def show_sum
    print "Sum of die is #{get_sum}.\n"
  end
end
