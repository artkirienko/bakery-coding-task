module Bakery
  class Printer
    def self.print_order(order)
      order.lines.map {|l| print_order_line(l)}.join
    end

    def self.print_order_line(line)
      s = "#{line.count} #{line.product.code} $#{line.price}\n"
      s << line.pack_counts.map do |pc|
        "    #{pc.count} x #{pc.pack.item_count} $#{pc.pack.price}\n"
      end.join
      s
    end
  end
end
