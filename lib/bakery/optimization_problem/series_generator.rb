module Bakery
  module OptimizationProblem
    class SeriesGenerator
      attr_reader :series, :series_counts, :equation

      def initialize(series_counts, equation)
        @series_counts = series_counts
        @equation = equation
        @series = []
      end

      def generate_series
        case series_counts.size
        when 2 then generate_ij
        when 3 then generate_ijk
        else generate_n
        end
        @series
      end

      private

      def generate_n(depth = 0, iterators = [])
        if depth < series_counts.size
          (0..series_counts[depth]).each do |i|
            iterators[depth] = i
            generate_n(depth + 1, iterators)
          end
        elsif equation.root?(iterators)
          @series.push(iterators.dup)
        end
      end

      def generate_ij
        (0..series_counts[0]).each do |i|
          (0..series_counts[1]).each do |j|
            @series << [i, j] if equation.root?([i, j])
          end
        end
      end

      def generate_ijk
        (0..series_counts[0]).each do |i|
          (0..series_counts[1]).each do |j|
            (0..series_counts[2]).each do |k|
              @series << [i, j, k] if equation.root?([i, j, k])
            end
          end
        end
      end
    end
  end
end
