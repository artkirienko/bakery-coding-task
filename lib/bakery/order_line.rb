require 'ostruct'

module Bakery
  class OrderLine
    OrderLineProductNotUnique = Class.new(StandardError)
    attr_reader :order, :product, :count

    def initialize(order, product, count)
      @order = order
      @product = product
      @count = count
      @packs = product.ordered_packs

      unless validate_order_line_product_uniqueness(product)
        raise OrderLineProductNotUnique
      end
      @order.lines << self
    end

    def price
      @price ||= calculate_price
    end

    def pack_counts
      best_combination.map.with_index do |count, i|
        OpenStruct.new(pack: @packs[i], count: count) unless count.zero?
      end.compact
    end

    def combination_price(combination)
      combination.map.with_index do |e, i|
        e * @packs[i].price
      end.sum
    end

    def combination_number_of_packs(combination)
      combination.sum
    end

    private

    def calculate_best_combination
      packs_counts = @packs.map(&:item_count)
      series_counts = packs_counts.map {|n| count / n}
      equation = OptimizationProblem::LinearDiophantineEquation.new(packs_counts, count)
      generator = OptimizationProblem::SeriesGenerator.new(series_counts, equation)
      series = generator.generate_series
      OptimizationProblem::MinMax.new(self, series)
                                 .min_by(:combination_number_of_packs)
                                 .max_by(:combination_price)
                                 .run
    end

    def calculate_price
      pack_counts.reduce(0) do |sum, pc|
        sum += (1.0 * pc.pack.price * pc.count)
      end.round(2)
    end

    def best_combination
      @best_combination ||= calculate_best_combination
    end

    def validate_order_line_product_uniqueness(product)
      order.lines.map(&:product).none? {|prod| prod.code == product.code}
    end
  end
end
