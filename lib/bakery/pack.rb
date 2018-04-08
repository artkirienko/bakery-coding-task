module Bakery
  class Pack
    PackItemCountNotUnique = Class.new(StandardError)
    attr_reader :product, :item_count, :price

    @all = []
    class << self
      attr_accessor :all
    end

    def initialize(product, item_count, price)
      @product = product
      @item_count = item_count
      @price = price

      unless validate_pack_item_count_uniqueness(item_count)
        raise PackItemCountNotUnique
      end

      @product.packs << self
      self.class.all << self
    end

    private

    def validate_pack_item_count_uniqueness(item_count)
      product.packs.map(&:item_count).none? { |count| count == item_count }
    end
  end
end
