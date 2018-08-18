RSpec.describe Bowlarama::Games::Player do
  let(:player) do
    described_class.new(name: 'Suso', pinfalls: Array.new(20) { rand(1..10) })
  end

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
    end
  end
end
