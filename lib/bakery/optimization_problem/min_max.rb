module Bakery
  module OptimizationProblem
    class MinMax
      def initialize(object, combinations)
        @object = object
        @combinations = combinations
      end

      def min_by(method_name)
        min = @combinations.min do |a, b|
          @object.send(method_name, a) <=> @object.send(method_name, b)
        end
        @combinations = @combinations.select do |a|
          @object.send(method_name, a) == @object.send(method_name, min)
        end
        self
      end

      def max_by(method_name)
        max = @combinations.max do |a, b|
          @object.send(method_name, a) <=> @object.send(method_name, b)
        end
        @combinations = @combinations.select do |a|
          @object.send(method_name, a) == @object.send(method_name, max)
        end
        self
      end

      def run
        @combinations.first
      end
    end
  end
end
