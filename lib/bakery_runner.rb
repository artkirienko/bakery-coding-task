require_relative 'bakery'

NOTICE = 'Looks like you have used "CTRL-C" to interrupt the program flow. ' \
         'Maybe you\'ve pressed it by mistake? ' \
         'Use "CTRL-D" to send EOF.'.freeze
NO_PRODUCTS = 'There are no products with this code'.freeze

def load_inventory
  Bakery::Inventory.load
end

def create_order
  @order = Bakery::Order.new
end

def parse_order_line(line)
  begin
    count, product_code = line.split
    count = count.to_i
    product = Bakery::Product.find_by_code(product_code)
    Bakery::OrderLine.new(@order, product, count)
  rescue Bakery::Product::ProductNotFound
    puts NO_PRODUCTS
  end
end

def print_order
  puts Bakery::Printer.print_order(@order)
end

begin
  load_inventory
  create_order
  ARGF.each do |line|
    parse_order_line(line)
  end
  print_order
rescue Interrupt
  puts '', NOTICE
  raise
end
