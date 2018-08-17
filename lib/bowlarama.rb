require "bowlarama/version"
require 'bowlarama/game'

module Bowlarama
  def self.score_sheet(scores_file)
    match_sheet = {}

    File.foreach(scores_file) do |l|
      splitted = l.split(' ')
      player_key = splitted.first.to_sym

      if match_sheet.key?(player_key)
        match_sheet[player_key] << splitted.last
      else
        match_sheet[player_key] = [splitted.last]
      end
    end

    player_1 = Game::Player.new(name: match_sheet.keys.first, pinfalls: match_sheet.values.first)
    player_2 = Game::Player.new(name: match_sheet.keys.last, pinfalls: match_sheet.values.last)

    player_1.calculate_score
  end
end

Bowlarama.score_sheet("#{Dir.pwd}/spec/fixtures/scores_sin_bonos.txt")
