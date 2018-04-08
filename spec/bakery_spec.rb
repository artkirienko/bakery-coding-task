require "bakery"

RSpec.describe Bakery do
  it "has a version number" do
    expect(Bakery::VERSION).not_to be nil
  end

  it "calculates totals correctly for example input" do
    Bakery::Inventory.load('spec/files/inventory.yml')
    order = Bakery::Order.new

    product = Bakery::Product.find_by_code('VS5')
    Bakery::OrderLine.new(order, product, 10)

    product = Bakery::Product.find_by_code('MB11')
    Bakery::OrderLine.new(order, product, 14)

    product = Bakery::Product.find_by_code('CF')
    Bakery::OrderLine.new(order, product, 13)

    vs5_line = order.lines.select {|line| line.product.code == 'VS5'}.first
    mb11_line = order.lines.select {|line| line.product.code == 'MB11'}.first
    cf_line = order.lines.select {|line| line.product.code == 'CF'}.first

    vs5_5_pack = vs5_line.pack_counts.select {|pc| pc.pack.item_count == 5}.first
    mb11_8_pack = mb11_line.pack_counts.select {|pc| pc.pack.item_count == 8}.first
    mb11_2_pack = mb11_line.pack_counts.select {|pc| pc.pack.item_count == 2}.first
    cf_5_pack = cf_line.pack_counts.select {|pc| pc.pack.item_count == 5}.first
    cf_3_pack = cf_line.pack_counts.select {|pc| pc.pack.item_count == 3}.first

    expect(order.total).to eq(98.63)
    expect(order.lines.size).to eq(3)
    expect(vs5_line.count).to eq(10)
    expect(mb11_line.count).to eq(14)
    expect(cf_line.count).to eq(13)
    expect(vs5_line.price).to eq(17.98)
    expect(mb11_line.price).to eq(54.8)
    expect(cf_line.price).to eq(25.85)
    expect(vs5_5_pack.count).to eq(2)
    expect(mb11_8_pack.count).to eq(1)
    expect(mb11_2_pack.count).to eq(3)
    expect(cf_5_pack.count).to eq(2)
    expect(cf_3_pack.count).to eq(1)
    expect(vs5_5_pack.pack.price).to eq(8.99)
    expect(mb11_8_pack.pack.price).to eq(24.95)
    expect(mb11_2_pack.pack.price).to eq(9.95)
    expect(cf_5_pack.pack.price).to eq(9.95)
    expect(cf_3_pack.pack.price).to eq(5.95)
  end

  describe '::Product' do
    describe '#packs' do
      it 'has many packs' do
        cake_08 = Bakery::Product.new('CAKE-08','Banoffee Pie')
        cake_08_pack_3 = Bakery::Pack.new(cake_08, 3, 15.15)
        cake_08_pack_8 = Bakery::Pack.new(cake_08, 8, 28.99)

        expect(cake_08.packs.count).to eq(2)
        expect(cake_08.packs).to include(cake_08_pack_3, cake_08_pack_8)
      end
    end

    describe '#ordered_packs' do
      it 'sort packs by item_count DESC' do
        cake_09 = Bakery::Product.new('CAKE-09','Red Velvet Cake')
        cake_09_pack_3 = Bakery::Pack.new(cake_09, 3, 15.15)
        cake_09_pack_8 = Bakery::Pack.new(cake_09, 8, 28.99)
        cake_09_pack_5 = Bakery::Pack.new(cake_09, 5, 22.45)

        expect(cake_09.ordered_packs).to match([cake_09_pack_8, cake_09_pack_5, cake_09_pack_3])
      end
    end
  end

  describe '::Order' do
    describe '#lines' do
      it 'has many lines' do
        order = Bakery::Order.new
        esp_10 = Bakery::Product.new('ESP-10', 'Iced Caffè Americano')
        esp_11 = Bakery::Product.new('ESP-11', 'Iced Caffè Latte')
        Bakery::Pack.new(esp_10, 1, 5.15)
        Bakery::Pack.new(esp_10, 2, 12.15)
        Bakery::Pack.new(esp_11, 1, 6.20)
        Bakery::Pack.new(esp_11, 3, 18.17)

        line_1 = Bakery::OrderLine.new(order, esp_10, 5)
        line_2 = Bakery::OrderLine.new(order, esp_11, 4)

        expect(order.lines.size).to eq(2)
        expect(order.lines).to include(line_1, line_2)
      end
    end

    describe '#total' do
      it 'calculates total' do
        order = Bakery::Order.new
        esp_12 = Bakery::Product.new('ESP-12', 'Iced Caffè Mocha')
        pack_1 = Bakery::Pack.new(esp_12, 1, 7.11)
        pack_3 = Bakery::Pack.new(esp_12, 3, 12.15)

        Bakery::OrderLine.new(order, esp_12, 6)
        expect(order.total).to eq(24.3)
      end
    end
  end
end
