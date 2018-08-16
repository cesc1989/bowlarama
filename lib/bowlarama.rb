require "bowlarama/version"

module Bowlarama
  SCORES_FILE = "#{Dir.pwd}/spec/fixtures/scores.txt".freeze

  game = {}

  File.foreach(SCORES_FILE) do |l|
    splitted = l.split(' ')
    player_key = splitted.first.to_sym

    if game.key?(player_key)
      game[player_key] << splitted[1]
    else
      game[player_key] = [splitted[1]]
    end
  end

  puts game
end
