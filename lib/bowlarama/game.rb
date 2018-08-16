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
        @pinfalls_clone = @pinfalls.clone
        @frames = Frame.frames
      end

      def scores_per_frame
        @frames.each do |frame|
          @pinfalls_clone.each do |pf|
            roll = pf.to_i

            if frame.slot_for_rolls?
              frame.rolls << roll
              @pinfalls_clone.delete_at(0)
            else
              break
            end
          end
        end
      end

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

      attr_accessor :rolls

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
