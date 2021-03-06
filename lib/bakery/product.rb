module Bakery
  class Product
    ProductCodeNotUnique = Class.new(StandardError)
    ProductNotFound = Class.new(StandardError)

    attr_reader :code, :name
    attr_accessor :packs

    @all = []
    class << self
      attr_accessor :all
    end

    def initialize(code, name)
      @code = code
      @name = name
      @packs = []

      unless validate_code_uniqueness(code)
        raise ProductCodeNotUnique
      end

      self.class.all << self
    end

    def ordered_packs
      packs.sort_by { |pack| -pack.item_count }
    end

    def self.find_by_code(code)
      product = all.find { |prod| prod.code == code }
      raise ProductNotFound unless product

      product
    end

    private

    def validate_code_uniqueness(code)
      self.class.all.none? { |product| product.code == code }
    end
  end
end
