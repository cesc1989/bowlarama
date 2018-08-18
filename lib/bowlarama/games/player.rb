module Bowlarama
  module Games
    class Player
      attr_reader :name, :frames

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
            roll = pf.to_i

            if frame.two_rolls?
              frame.mark_as_spare if frame.mark_as_spare?
              next
            end

            if frame.slot_for_rolls?
              frame.rolls << roll

              frame.mark_as_strike if frame.strike?

              break # Move to the next pinfall immediatly
            end
          end
        end
      end

      def calculate_score_per_frames
        previous_score = 0

        @frames.each_with_index do |frame, index|
          previous_frame = @frames[index - 1]
          current_frame_rolls_summed = frame.rolls.reduce(:+)

          if index > 0 && previous_frame.has_strike
            previous_frame.score += current_frame_rolls_summed
            previous_score = previous_frame.score
          end

          if index > 0 && previous_frame.has_spare
            previous_frame.score += frame.rolls.first
            previous_score = previous_frame.score
          end

          previous_score += current_frame_rolls_summed
          frame.score = previous_score
        end
      end
    end
  end
end