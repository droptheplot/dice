module Dice
  class Store < Hash
    def add(dices, number, result)
      self[dices] = {} if self[dices].nil?
      self[dices][number] = result
    end

    def exists?(dices, number)
      !self[dices].nil? && !self[dices][number].nil?
    end

    def get(dices, number)
      return false unless exists?(dices, number)

      self[dices][number]
    end
  end

  class Calculator
    SIDES = 6

    # Store calculated probabilities for future use
    # @return [Hash{ Integer => Hash { Integer => Float } }]
    attr_reader :cache

    def initialize(options = {})
      @cache = options.fetch(:store, Dice::Store.new)
    end

    # Calculate probability
    # @param dices [Integer] amount of dices to throw
    # @param number [Integer] magic number we want
    # @return [Integer]
    def probability(dices, number)
      return @cache.get(dices, number) if @cache.exists?(dices, number)

      if dices <= 0
        return 0.0
      elsif dices == 1
        return (1..SIDES).cover?(number) ? 1.0 / SIDES : 0.0
      end

      result = prev_numbers(number).map { |n| probability(dices - 1, n) }
                                   .inject(&:+) / SIDES

      @cache.add(dices, number, result)

      result
    end

    private

      # @return [Array{ Integer }]
      def prev_numbers(number)
        ((number - SIDES)..(number - 1)).map { |i| i < 0 ? 0 : i }
      end
  end
end
