module Bowlarama
  module Games
    class Frame
      def self.frames(amount = 10)
        amount.times.map do |n|
          Frame.new(n + 1)
        end
      end

      attr_reader :id
      attr_accessor :rolls, :score, :has_strike, :has_spare

      def initialize(id)
        @id = id
        @rolls = []
        @score = 0
        @has_strike = false
        @has_spare = false
      end

      def slot_for_rolls?
        rolls.count < 2
      end
    end
  end
end
