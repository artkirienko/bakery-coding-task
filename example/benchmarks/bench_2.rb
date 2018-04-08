require_relative '../../lib/bakery'

Bakery::Inventory.load('spec/files/inventory.yml')
order = Bakery::Order.new

product = Bakery::Product.find_by_code('CF')
Bakery::OrderLine.new(order, product, 130)

puts Bakery::Printer.print_order(order)
