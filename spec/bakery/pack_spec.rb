require 'bakery/product'
require 'bakery/pack'

RSpec.describe Bakery::Pack do
  describe '::all' do
    it 'includes all packs' do
      cake_01 = Bakery::Product.new('CAKE-01','Caramel Marble Cake')
      cake_02 = Bakery::Product.new('CAKE-02','Blueberry Cheesecake')
      cake_03 = Bakery::Product.new('CAKE-03','Espresso Chocolate Chip Brownie')
      cake_01_pack_2 = described_class.new(cake_01, 2, 5.15)
      cake_01_pack_4 = described_class.new(cake_01, 5, 9.99)
      cake_02_pack_3 = described_class.new(cake_02, 3, 5.15)
      cake_02_pack_6 = described_class.new(cake_02, 6, 9.99)
      cake_02_pack_10 = described_class.new(cake_02, 10, 12.64)
      cake_03_pack_5 = described_class.new(cake_03, 5, 12.00)
      cake_03_pack_10 = described_class.new(cake_03, 10, 22.00)

      expect(described_class.all).to include(
        cake_01_pack_2, cake_01_pack_4, cake_02_pack_3, cake_02_pack_6,
        cake_02_pack_10, cake_03_pack_5, cake_03_pack_10
      )
    end
  end

  describe '::new' do
    it 'validates pack item count uniqueness' do
      cake_04 = Bakery::Product.new('CAKE-04','Chocolate Marble Cake')
      described_class.new(cake_04, 4, 15.15)

      expect { described_class.new(cake_04, 4, 18.15) }.to raise_error(described_class::PackItemCountNotUnique)
    end
  end

  describe '#item_count' do
    it 'attribute' do
      cake_05 = Bakery::Product.new('CAKE-05','Mango Yoghurt Cake')

      expect(described_class.new(cake_05, 3, 10.00).item_count).to eq(3)
    end
  end

  describe '#price' do
  it 'attribute' do
    cake_06 = Bakery::Product.new('CAKE-06','Coconut Cake')

    expect(described_class.new(cake_06, 1, 9.99).price).to eq(9.99)
  end
end

  describe '#product' do
    it 'attribute' do
      cake_07 = Bakery::Product.new('CAKE-07','Signature Chocolate Cake')

      expect(described_class.new(cake_07, 1, 9.99).product).to eq(cake_07)
    end
  end
end
