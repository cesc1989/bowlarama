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
        # @frames.each { |f| puts f.inspect }
      end

      def assign_rolls_to_frames
        @pinfalls.each do |pf|
          @frames.each do |frame|
            roll = pf.to_i

            if frame.slot_for_rolls?
              frame.rolls << roll
              if strike?(roll)
                frame.rolls << 0
                frame.has_strike = true
              end

              break
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

          previous_score += current_frame_rolls_summed
          frame.score = previous_score
        end
      end

      private

      def strike?(roll)
        roll == 10
      end

      # Receives reduced array of rolls
      # frame.rolls.reduce(:+)
      def spare?(rolls)
        rolls == 10
      end

      def foul?(pinfal)
        pinfal == 'F'
      end
    end
  end
end