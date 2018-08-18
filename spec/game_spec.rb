RSpec.describe Bowlarama::Game do
  describe 'Constants' do
    it 'has a strike sign as constant' do
      expect(Bowlarama::Game::STRIKE_SIGN).to eq 'X'
    end

    it 'has a spare sign as constant' do
      expect(Bowlarama::Game::SPARE_SIGN).to eq '/'
    end
  end

  describe 'Instance methods' do
    let(:game) do
      described_class.new(
        Bowlarama::Games::Player.new(name: 'Suso', pinfalls: Array.new(20) { rand(1..9) }),
        Bowlarama::Games::Player.new(name: 'Chana', pinfalls: Array.new(20) { rand(1..9) })
      )
    end

    describe '#print_score' do
      before do
        @score_table = game.print_score
      end

      it 'prints the score table' do
        expect(@score_table).to be_a(String)
      end

      it 'is seven lines long' do
        expect(@score_table.lines.count).to eq(7)
      end

      it 'displays player 1 name' do
        expect(@score_table).to include('Suso')
      end

      it 'displays player 2 name' do
        expect(@score_table).to include('Chana')
      end
    end
  end
end
