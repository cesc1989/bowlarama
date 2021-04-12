module Bowlarama
  module Games
    class Frame
      def self.frames(amount = 10)
        amount.times.map do |n|
          Frame.new(n + 1)
        end
      end

      attr_reader :id
      attr_accessor :rolls,
                    :score,
                    :has_strike,
                    :has_spare,
                    :raw_rolls

      def initialize(id)
        @id = id
        @rolls = []
        @raw_rolls = [] # contains original(string) pinfalls to display
        @score = 0
        @has_strike = false
        @has_spare = false
      end

      def slot_for_rolls?
        rolls.count < 2
      end

      def two_rolls?
        rolls.count == 2
      end

      def spare?
        return false if rolls.first == 10

        rolls.reduce(:+) == 10
      end

      def mark_as_spare?
        two_rolls? && spare?
      end

      def mark_as_spare
        self.has_spare = true
      end

      def strike?
        rolls.first == 10
      end

      def mark_as_strike
        rolls << 0

        self.has_strike = true
      end
    end
  end
end
