require 'bakery/optimization_problem/linear_diophantine_equation'

RSpec.describe Bakery::OptimizationProblem::LinearDiophantineEquation do
  describe '::new' do
    it 'validates equation has solution' do
      expect { described_class.new([2, 4], 7) }.to raise_error(described_class::EquationHasNoSolutionsError)
    end
  end

  describe '#root?' do
    it 'true' do
      equation = described_class.new([2, 4], 6)
      coordinates = [3, 0]

      expect(equation.root?(coordinates)).to be_truthy
    end

    it 'false' do
      equation = described_class.new([2, 4], 6)
      coordinates = [2, 1]

      expect(equation.root?(coordinates)).to be_falsy
    end
  end
end
