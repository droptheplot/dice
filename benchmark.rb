require 'benchmark'
require_relative 'dice'

Benchmark.bmbm(10) do |x|
  x.report('100 x 100') { Dice::Calculator.new.probability(100, 100) }
  x.report('300 x 300') { Dice::Calculator.new.probability(300, 300) }
  x.report('500 x 500') { Dice::Calculator.new.probability(500, 500) }
end
