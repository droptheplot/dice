require 'rspec'
require_relative 'dice'

describe Dice::Calculator do
  describe '#probability' do
    context 'for given amount of dices and magic number' do
      before do
        @calculator = Dice::Calculator.new
      end

      it 'returns correct probability' do
        expect(@calculator.probability(2, 1)).to eq(0)
        expect(@calculator.probability(2, 2)).to eq(1.0 / 36)
        expect(@calculator.probability(3, 15)).to be_within(0.000001).of(5.0 / 108)
        expect(@calculator.probability(100, 100)).to be_within(0.000001).of(1.531 * 10 ** -78)
        expect(@calculator.probability(300, 300)).to be_within(0.000001).of(3.586 * 10 ** -234)
      end
    end
  end
end
