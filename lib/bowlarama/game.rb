module Bowlarama
  class Game
    STRIKE_SIGN = 'X'.freeze
    SPARE_SIGN = '/'.freeze

    def initialize(*players)
      @players = players
      @score = ''
    end

    def print_score
      results
      score_headers
      players_data

      puts @score
      @score
    end

    private

    def results
      @players.each { |player| player.calculate_score }
    end

    def score_headers
      @score << "Frame\t\t"
      @score << [*1..10].join("\t\t")
      @score << "\n"
    end

    def players_data
      @players.each do |player|
        player_frames = player.frames
        player_frames_count = player_frames.count

        @score << "#{player.name}\n"
        @score << "Pinfalls\t"

        print_player_rolls(player_frames)

        @score << "Score\t\t"

        print_player_scores(player_frames)
      end
    end

    def print_player_rolls(player_frames)
      player_frames.each_with_index do |frame, index|
        @score << print_strike_or_spare(frame)
        @score << "\n" if index == player_frames.count - 1
      end
    end

    def print_player_scores(player_frames)
      player_frames.each_with_index do |frame, index|
        @score << "#{frame.score}\t\t"
        @score << "\n" if index == player_frames.count - 1
      end
    end

    def print_strike_or_spare(frame)
      if !frame.has_strike && !frame.has_spare
        "#{frame.rolls.first}\t#{frame.rolls.last}\t"
      elsif frame.has_strike && !frame.has_spare
        " \t#{STRIKE_SIGN}\t"
      elsif !frame.has_strike && frame.has_spare
        "#{frame.rolls.first}\t#{SPARE_SIGN}\t"
      end
    end
  end
end
