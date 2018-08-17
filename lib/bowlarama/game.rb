module Bowlarama
  class Game
    def initialize(*players)
      @players = players
      @score = ''
    end

    def print_score
      results
      score_headers
      players_data
      puts @score
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
        @score << "#{player.name}\n"
        @score << "Pinfalls\t"

        player.frames.each_with_index do |frame, index|
          @score << "#{frame.rolls.first}\t#{frame.rolls.last}\t"
          @score << "\n" if index == player.frames.count - 1
        end

        @score << "Score\t\t"

        player.frames.each_with_index do |frame, index|
          @score << "#{frame.score}\t\t"
          @score << "\n" if index == player.frames.count - 1
        end
      end
    end
  end
end
