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
        @frames.each { |f| puts f.inspect }
      end

      def assign_rolls_to_frames
        @pinfalls.each do |pf|
          @frames.each do |frame|
            frame_rolls_count = frame.rolls.count
            roll = pf.to_i

            if frame_rolls_count == 2 && spare?(frame.rolls)
              frame.has_spare = true
            end

            next if frame_rolls_count == 2

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

          if index > 0 && previous_frame.has_spare
            previous_frame.score += frame.rolls.first
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