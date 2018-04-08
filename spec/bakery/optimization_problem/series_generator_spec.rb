require 'bakery/optimization_problem/series_generator'

RSpec.describe Bakery::OptimizationProblem::SeriesGenerator do
  describe '#generate_series' do
    it 'example #1' do
      equation = double()
      allow(equation).to receive(:root?) { true }
      generator = described_class.new([2, 4], equation)
      result = [[0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [1, 0], [1, 1], [1, 2],
                [1, 3], [1, 4], [2, 0], [2, 1], [2, 2], [2, 3], [2, 4]].freeze

      expect(generator.generate_series).to match(result)
    end

    it 'example #2' do
      equation = double()
      allow(equation).to receive(:root?) { true }
      generator = described_class.new([1, 2, 7], equation)
      result = [[0, 0, 0], [0, 0, 1], [0, 0, 2], [0, 0, 3], [0, 0, 4],
                [0, 0, 5], [0, 0, 6], [0, 0, 7], [0, 1, 0], [0, 1, 1],
                [0, 1, 2], [0, 1, 3], [0, 1, 4], [0, 1, 5], [0, 1, 6],
                [0, 1, 7], [0, 2, 0], [0, 2, 1], [0, 2, 2], [0, 2, 3],
                [0, 2, 4], [0, 2, 5], [0, 2, 6], [0, 2, 7], [1, 0, 0],
                [1, 0, 1], [1, 0, 2], [1, 0, 3], [1, 0, 4], [1, 0, 5],
                [1, 0, 6], [1, 0, 7], [1, 1, 0], [1, 1, 1], [1, 1, 2],
                [1, 1, 3], [1, 1, 4], [1, 1, 5], [1, 1, 6], [1, 1, 7],
                [1, 2, 0], [1, 2, 1], [1, 2, 2], [1, 2, 3], [1, 2, 4],
                [1, 2, 5], [1, 2, 6], [1, 2, 7]].freeze

      expect(generator.generate_series).to match(result)
    end

    it 'example #3' do
      equation = double()
      allow(equation).to receive(:root?) { true }
      generator = described_class.new([1, 1, 1, 1], equation)
      result = [[0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 1, 0], [0, 0, 1, 1],
                [0, 1, 0, 0], [0, 1, 0, 1], [0, 1, 1, 0], [0, 1, 1, 1],
                [1, 0, 0, 0], [1, 0, 0, 1], [1, 0, 1, 0], [1, 0, 1, 1],
                [1, 1, 0, 0], [1, 1, 0, 1], [1, 1, 1, 0], [1, 1, 1, 1]].freeze

      expect(generator.generate_series).to match(result)
    end
  end
end
