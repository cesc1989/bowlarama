RSpec.describe Bowlarama::Games::Frame do
  describe '.frames' do
    it 'generates an array of frames' do
      frames = described_class.frames
      expect(frames).to be_a(Array)
      expect(frames.first).to be_a(described_class)
    end
  end

  describe 'Instance methods' do
    let(:frame) { described_class.new(1) }

    describe '#id' do
      it 'has an identifier' do
        expect(frame.id).to eq 1
      end

      it 'receives to the :id message' do
        expect(frame).to respond_to(:id)
      end
    end

    describe '#rolls' do
      it 'receives to the :rolls message' do
        expect(frame).to respond_to(:rolls)
      end
    end

    describe '#score' do
      it 'receives to the :score message' do
        expect(frame).to respond_to(:score)
      end
    end

    describe '#has_strike' do
      it 'receives to the :has_strike message' do
        expect(frame).to respond_to(:has_strike)
      end
    end

    describe '#has_spare' do
      it 'receives to the :has_spare message' do
        expect(frame).to respond_to(:has_spare)
      end
    end
  end
end
