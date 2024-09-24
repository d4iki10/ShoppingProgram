# Ownableモジュールを定義する
module Ownable
  attr_accessor :owner

  def change_owner(new_owner)
    self.owner = new_owner
  end
end

class Wallet
  # Ownableモジュールをこのクラスに追加する
  include Ownable
  
  attr_reader :balance

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