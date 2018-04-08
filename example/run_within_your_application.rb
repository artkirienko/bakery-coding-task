require_relative '../lib/bakery'

Bakery::Inventory.load
order = Bakery::Order.new

product = Bakery::Product.all.first
Bakery::OrderLine.new(order, product, 10)

product = Bakery::Product.find_by_code('MB11')
Bakery::OrderLine.new(order, product, 14)

product = Bakery::Product.all.last
Bakery::OrderLine.new(order, product, 13)

# You can get all the values you need by inspecting objects:
order.lines.each do |line|
  line.count
  line.product.code
  line.price

  line.pack_counts.each do |pc|
    pc.count
    pc.pack.item_count
    pc.pack.price
  end
end

order.total

# Or you can get preformatted text:
puts Bakery::Printer.print_order(order)
