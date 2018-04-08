module Bakery
  class Order
    attr_accessor :lines

    def initialize
      @lines = []
    end

    def total
      lines.map(&:price).sum
    end
  end
end
