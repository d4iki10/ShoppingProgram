# Ownableモジュールを定義する
module Ownable
  attr_accessor :owner

  def change_owner(new_owner)
    self.owner = new_owner
  end
end


class Item
  # Ownableモジュールをこのクラスに追加する
  include Ownable
  
  attr_reader :number, :name, :price

  @@instances = []

  def initialize(number, name, price, owner=nil)
    @number = number
    @name = name
    @price = price
    self.owner = owner

    # Itemインスタンスの生成時、そのItemインスタンス(self)は、@@insntancesというクラス変数に格納されます。
    @@instances << self
  end

  def label
    { number: number, name: name, price: price }
  end

  def self.all
    #　@@instancesを返します ==> Item.allでこれまでに生成されたItemインスタンスを全て返すということです。
    @@instances
  end

end