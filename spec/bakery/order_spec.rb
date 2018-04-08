require 'bakery/order'

RSpec.describe Bakery::Order do
  describe '#lines' do
    it 'to be empty, when new order is created' do
      expect(described_class.new.lines).to be_empty
    end
  end

  describe '#total' do
    it 'to eq 0.0, when order has no lines' do
      expect(described_class.new.total).to be_zero
    end
  end
end
