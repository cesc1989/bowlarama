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

            mark_frame_as_spare(frame)

            next if frame.rolls.count == 2

            if frame.slot_for_rolls?
              frame.rolls << roll

              mark_frame_as_strike(frame, roll)

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

      private

      def mark_frame_as_spare(frame)
        frame_rolls = frame.rolls

        if frame_rolls.count == 2 && spare?(frame_rolls)
          frame.has_spare = true
        end
      end

      def mark_frame_as_strike(frame, roll)
        if strike?(roll)
          frame.rolls << 0
          frame.has_strike = true
        end
      end

      def strike?(roll)
        roll == 10
      end

      # Receives array of rolls: [roll_1, roll_2]
      def spare?(rolls)
        return false if rolls.first == 10
        rolls.reduce(:+) == 10
      end

      def foul?(pinfal)
        pinfal == 'F'
      end
    end
  end
end