module Bowlarama
  module Games
    class Player
      attr_reader :name

      def initialize(name:, pinfalls:)
        @name = name
        @pinfalls = pinfalls
        @frames = Frame.frames
      end

      def calculate_score
        assign_rolls_to_frames
        calculate_score_per_frames
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

      def calculate_score_per_frames
        prev_frame_score = 0
        @frames.each do |frame|
          prev_frame_score += frame.rolls.reduce(:+)
          frame.score = prev_frame_score
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
  end
end