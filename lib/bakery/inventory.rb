require 'yaml'

module Bakery
  class Inventory
    DEFAULT_INVENTORY_PATH = 'config/inventory.yml'.freeze

    def self.load(path = DEFAULT_INVENTORY_PATH)
      inventory = YAML.load_file(path)
      inventory['products'].each do |product_info|
        product = Product.new(product_info['code'], product_info['name'])
        product_info['packs'].each do |pack_info|
          Pack.new(product, pack_info['item_count'], pack_info['price'])
        end
      end
    end

    def self.dump(path = DEFAULT_INVENTORY_PATH)
      products = Product.all.map do |product|
        h = { 'code' => product.code, 'name' => product.name }
        h['packs'] = product.packs.map do |pack|
          { 'item_count' => pack.item_count, 'price' => pack.price }
        end
        h
      end
      inventory = { 'products' => products }
      f = File.new(path, 'w')
      f.write(YAML.dump(inventory))
      f.close
    end
  end
end
