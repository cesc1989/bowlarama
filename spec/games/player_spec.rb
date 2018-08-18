RSpec.describe Bowlarama::Games::Player do
  let(:player) { described_class.new(name: 'Suso', pinfalls: Array.new(20) { rand(1..9) }) }

  describe 'Instance methods' do
    describe '#frames' do
      it 'returns an array of frames' do
        expect(player.frames).to be_a(Array)
      end
    end

    describe '#name' do
      it 'returnns the name of the player' do
        expect(player.name).to eq 'Suso'
      end
    end

    describe '#assign_rolls_to_frames' do
      it 'assigns given rolls to frames' do
        player.assign_rolls_to_frames
        expect(player.frames.first.rolls.count).to be > 0
      end

      context 'when there is a strike' do
        let(:pinfalls) { Array.new(18) { rand(1..9) } }
        let(:striker) { described_class.new(name: 'Juanchopolo', pinfalls: pinfalls.insert(0, 10)) }

        it 'marks frame with strike' do
          striker.assign_rolls_to_frames
          expect(striker.frames.first.has_strike).to be true
        end
      end

      context 'when there is a spare' do
        let(:pinfalls) { Array.new(18) { rand(1..9) } }
        let(:sparer) { described_class.new(name: 'Maria', pinfalls: pinfalls.insert(0, 7, 3)) }

        it 'marks frame with spare' do
          sparer.assign_rolls_to_frames
          expect(sparer.frames.first.has_spare).to be true
        end
      end
    end

    describe '#calculate_score_per_frames' do
      it 'assigns scores to frames' do
        player.assign_rolls_to_frames
        player.calculate_score_per_frames
        expect(player.frames.first.score).not_to be 0
      end
    end
  end
end
