class Wallet
  attr_reader :balance
  attr_accessor :owner

  def initialize(owner)
    self.owner = owner
    @balance = 0
  end

  def deposit(amount)
    @balance += amount.to_i
  end

  def withdraw(amount)
    return unless @balance >= amount
    @balance -= amount.to_i
    amount
  end

end