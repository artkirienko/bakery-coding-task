module Bakery
  module OptimizationProblem
    class LinearDiophantineEquation
      EquationHasNoSolutionsError = Class.new(StandardError)

      def initialize(coefficients, constant_term)
        @coefficients = coefficients
        @constant_term = constant_term
        raise EquationHasNoSolutionsError unless has_solution?
      end

      def root?(coordinates)
        @coefficients.map.with_index {|e, i| e * coordinates[i]}.sum == @constant_term
      end

      private

      def has_solution?
        @constant_term % @coefficients.reduce(:gcd) == 0
      end
    end
  end
end
