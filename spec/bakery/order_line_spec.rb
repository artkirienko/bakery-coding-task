require 'bakery/order_line'
require 'bakery/order'
require 'bakery/product'
require 'bakery/pack'

RSpec.describe Bakery::OrderLine do
  describe '::new' do
    it 'validates order line product uniquenes' do
      brw_01 = Bakery::Product.new('BRW-01', 'Brewed Coffee by French Press')
      Bakery::Pack.new(brw_01, 1, 5.35)
      order = Bakery::Order.new
      described_class.new(order, brw_01, 3)

      expect { described_class.new(order, brw_01, 7) }.to raise_error(described_class::OrderLineProductNotUnique)
    end
  end

  describe '#price' do
    it 'calculates price' do
      brw_02 = Bakery::Product.new('BRW-02', 'Caffè Misto')
      Bakery::Pack.new(brw_02, 2, 20.20)
      Bakery::Pack.new(brw_02, 3, 25.20)
      order = Bakery::Order.new
      order_line = described_class.new(order, brw_02, 6)

      expect(order_line.price).to eq(2 * 25.20)
    end
  end

  describe '#pack_counts' do
    it 'returns best packs and counts' do
      esp_13 = Bakery::Product.new('ESP-13', 'Iced Caramel Macchiato')
      pack_1 = Bakery::Pack.new(esp_13, 1, 7.11)
      pack_4 = Bakery::Pack.new(esp_13, 4, 12.15)
      order = Bakery::Order.new
      order_line = Bakery::OrderLine.new(order, esp_13, 9)

      # 9 == 2 x pack_4 + 1 x pack_1

      expect(order_line.pack_counts.size).to eq(2)

      pc_1 = order_line.pack_counts.find { |pc| pc.pack == pack_1 }
      pc_4 = order_line.pack_counts.find { |pc| pc.pack == pack_4 }

      expect(pc_1.pack).to eq(pack_1)
      expect(pc_1.count).to eq(1)
      expect(pc_4.pack).to eq(pack_4)
      expect(pc_4.count).to eq(2)
    end
  end

  describe '#combination_price' do
    it 'calculates combination price' do
      brw_03 = Bakery::Product.new('BRW-03', 'Coffee of the Week')
      Bakery::Pack.new(brw_03, 2, 20.20)
      Bakery::Pack.new(brw_03, 3, 25.20)
      order = Bakery::Order.new
      order_line = described_class.new(order, brw_03, 8)
      combination = [2, 1]

      expect(order_line.combination_price(combination)).to eq(2 * 25.20 + 1 * 20.20)
    end
  end

  describe '#combination_number_of_packs' do
    it 'counts number of packs' do
      brw_04 = Bakery::Product.new('BRW-04', 'Iced Coffee')
      Bakery::Pack.new(brw_04, 2, 20.20)
      Bakery::Pack.new(brw_04, 3, 25.20)
      order = Bakery::Order.new
      order_line = described_class.new(order, brw_04, 11)
      combination = [3, 1]

      expect(order_line.combination_number_of_packs(combination)).to eq(3 + 1)
    end
  end

  describe '#order' do
    it 'attribute' do
      chc_01 = Bakery::Product.new('CHC-01', 'Signature Hot Chocolate')
      Bakery::Pack.new(chc_01, 1, 13.30)
      order = Bakery::Order.new
      order_line = described_class.new(order, chc_01, 1)

      expect(order_line.order).to eq(order)
    end
  end

  describe '#product' do
    it 'attribute' do
      fr_01 = Bakery::Product.new('FR-01', 'Caramel Frappuccino® Blended Beverage')
      Bakery::Pack.new(fr_01, 1, 18.30)
      order = Bakery::Order.new
      order_line = described_class.new(order, fr_01, 1)

      expect(order_line.product).to eq(fr_01)
    end
  end

  describe '#count' do
    it 'attribute' do
      fr_02 = Bakery::Product.new('FR-02', 'Java Chip Frappuccino® Blended Beverage')
      Bakery::Pack.new(fr_02, 1, 19.90)
      order = Bakery::Order.new
      order_line = described_class.new(order, fr_02, 4)

      expect(order_line.count).to eq(4)
    end
  end
end
