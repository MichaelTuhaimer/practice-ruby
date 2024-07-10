# item1 = { name: "apple", type: "fruit", price: 1.99 }
# item2 = { name: "milk", type: "dairy", price: 4.99 }
# item3 = { :name => "steak", :type => "meat", :price => 11.99 }
# pp item1
# pp item2
# pp item3

class Item
  attr_reader :name, :type, :price
  attr_writer :price, :stock

  def initialize(item)
    @name = item[:name]
    @type = item[:type]
    @price = item[:price]
    @stock = item[:stock]
  end

  def stock
    if @stock == true
      puts "#{@name} is in stock."
    else
      puts "#{@name} is out of stock."
    end
  end
end

item1 = Item.new({ name: "apple", type: "fruit", price: 1.99, stock: true })
item2 = Item.new({ name: "milk", type: "dairy", price: 4.99, stock: true })
item3 = Item.new({ name: "steak", type: "meat", price: 11.99, stock: true })
puts item1.name
puts item1.type
puts item1.price
puts item3.price
item3.price = 14.99
puts item3.price
item1.stock
item2.stock = false
item2.stock
