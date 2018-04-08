require 'bakery/product'

RSpec.describe Bakery::Product do
  describe '::all' do
    it 'includes all products' do
      esp_01 = described_class.new('ESP-01', 'Caffè Americano')
      esp_02 = described_class.new('ESP-02', 'Caffè Latte')
      esp_03 = described_class.new('ESP-03', 'Caffè Mocha')

      expect(described_class.all).to include(esp_01, esp_02, esp_03)
    end
  end

  describe '::find_by_code' do
    it 'can be found by code' do
      esp_04 = described_class.new('ESP-04', 'White Chocolate Mocha')
      esp_05 = described_class.new('ESP-05', 'Cappuccino')
      esp_06 = described_class.new('ESP-06', 'Caramel Macchiato')

      expect(described_class.find_by_code('ESP-05')).to eq(esp_05)
    end

    it 'raises ProductNotFound error' do
      expect { described_class.find_by_code('ESP-00') }.to raise_error(described_class::ProductNotFound)
    end
  end

  describe '::new' do
    it 'validate_code_uniqueness' do
      esp_07 = described_class.new('ESP-07', 'Espresso Solo')
      
      expect { described_class.new('ESP-07', 'Espresso Con Panna') }.to raise_error(described_class::ProductCodeNotUnique)
    end
  end

  describe '#code' do
    it 'attribute' do
      expect(described_class.new('ESP-08', 'Espresso Con Panna').code).to eq('ESP-08')
    end
  end

  describe '#name' do
    it 'attribute' do
      expect(described_class.new('ESP-09', 'Espresso Macchiato').name).to eq('Espresso Macchiato')
    end
  end
end
