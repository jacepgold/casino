class Wallet
  attr_accessor :amount
  def initialize(amount)
    @amount = amount
  end

  def add_wallet(num)
    @amount += num
  end

  def sub_wallet(num)
    @amount -= num
  end

end
