require_relative "item_manager"

class Cart
  # attr_accessorで、ownerというインスタンス変数を読み書き可能にします
  attr_accessor :owner
  
  include ItemManager

  def initialize(owner)
    self.owner = owner
    @items = []
  end

  def items
    # Cartにとってのitemsは自身の@itemsとしたいため、ItemManagerのitemsメソッドをオーバーライドします。
    # CartインスタンスがItemインスタンスを持つときは、オーナー権限の移譲をさせることなく、自身の@itemsに格納(Cart#add)するだけだからです。
    @items
  end

  def add(item)
    @items << item
  end

  def total_amount
    @items.sum(&:price)
  end

  def check_out
    return if owner.wallet.balance < total_amount
    @items.each do |item|
      # カートのオーナーのウォレットからアイテムの価格を引き出す
      owner.wallet.withdraw(item.price)
      # アイテムのオーナーのウォレットにアイテムの価格を入金する
      item.owner.wallet.deposit(item.price)
      # アイテムのオーナー権限をカートのオーナーに移す
      item.owner = owner
    end

    # カートの中身を空にする
    @items.clear
  end

end
