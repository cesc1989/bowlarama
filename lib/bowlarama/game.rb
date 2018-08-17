module Bowlarama
  class Game
    def initialize(player_1, player_2)
      @player_1 = player_1
      @player_2 = player_2
    end

    class Player
      attr_reader :name

      def initialize(name:, pinfalls:)
        @name = name
        @pinfalls = pinfalls
        @frames = Frame.frames
      end

      def assign_rolls_to_frames
        @pinfalls.each do |pf|
          @frames.each do |frame|
            if frame.slot_for_rolls?
              frame.rolls << pf.to_i
              break
            end
          end
        end
      end

      def calculate_score_per_frames; end

      private

      def strike?(roll)
        roll == 10
      end

      def spare?(rolls)
        rolls == 10
      end

      def foul?(pinfal)
        pinfal == 'F'
      end
    end

    class Frame
      def self.frames(amount = 10)
        amount.times.map do |n|
          Frame.new(n + 1)
        end
      end

      attr_reader :id
      attr_accessor :rolls, :score

      def initialize(id)
        @id = id
        @rolls = []
        @score = 0
      end

      def slot_for_rolls?
        rolls.count < 2
      end
    end
  end
end
