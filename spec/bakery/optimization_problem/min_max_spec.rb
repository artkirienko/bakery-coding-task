require 'bakery/optimization_problem/min_max'

RSpec.describe Bakery::OptimizationProblem::MinMax do
  describe '#min_by.run' do
    it 'finds min by metric' do
      object = Object.new

      def object.metric(array)
        array.map {|e| e * 10 + 1}.sum - 10
      end

      combinations = [2, 0], [2, 2]
      min_max = described_class.new(object, combinations)
      
      expect(min_max.min_by(:metric).run).to match([2, 0])
    end
  end

  describe '#max_by.run' do
    it 'finds max by metric' do
      object = Object.new

      def object.metric(array)
        array.sum
      end

      combinations = [2, 0], [2, 2]
      min_max = described_class.new(object, combinations)

      expect(min_max.max_by(:metric).run).to match([2, 2])
    end
  end

  describe '#min_by.max_by.run' do
    it 'finds min by metric_1, finds max by metric_2' do
      object = Object.new

      def object.metric_1(array)
        array.sum
      end

      def object.metric_2(array)
        array.reduce(:*)
      end

      combinations = [2, 0], [1, 1]
      min_max = described_class.new(object, combinations)

      expect(min_max.min_by(:metric_1).max_by(:metric_2).run).to match([1, 1])
    end
  end
end
