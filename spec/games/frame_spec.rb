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
        expect(frame).to respond_to(:rolls=)
      end
    end

    describe '#score' do
      it 'receives to the :score message' do
        expect(frame).to respond_to(:score)
        expect(frame).to respond_to(:score=)
      end
    end

    describe '#has_strike' do
      it 'receives to the :has_strike message' do
        expect(frame).to respond_to(:has_strike)
        expect(frame).to respond_to(:has_strike=)
      end
    end

    describe '#has_spare' do
      it 'receives to the :has_spare message' do
        expect(frame).to respond_to(:has_spare)
        expect(frame).to respond_to(:has_spare=)
      end
    end

    describe '#slot_for_rolls?' do
      context 'when there are no rolls' do
        it 'is true' do
          expect(frame.slot_for_rolls?).to be true
        end
      end

      context 'when there are rolls' do
        before { frame.rolls = [1, 2] }

        it 'is false' do
          expect(frame.slot_for_rolls?).to be false
        end
      end
    end

    describe '#two_rolls?' do
      context 'when there are two rolls' do
        before { frame.rolls = [3, 4] }

        it 'is true' do
          expect(frame.two_rolls?).to be true
        end
      end

      context 'when there are not two rolls' do
        it 'is false' do
          expect(frame.two_rolls?).to be false
        end
      end
    end

    describe '#spare?' do
      context 'when rolls are not a spare' do
        before { frame.rolls = [5, 2] }

        it 'is false' do
          expect(frame.spare?).to be false
        end
      end

      context 'when first roll is a strike' do
        before { frame.rolls = [10, 0] }

        it 'is false' do
          expect(frame.spare?).to be false
        end
      end

      context 'when rolls are a spare' do
        before { frame.rolls = [5, 5] }

        it 'is true' do
          expect(frame.spare?).to be true
        end
      end
    end

    describe '#mark_as_spare' do
      before { frame.mark_as_spare }

      it 'marks frame as spare' do
        expect(frame.has_spare).to be true
      end
    end

    describe '#mark_as_strike' do
      before do
        frame.rolls << 10
        frame.mark_as_strike
      end

      it 'marks frame as strike' do
        expect(frame.has_strike).to be true
      end

      it 'has a last roll of 0' do
        expect(frame.rolls.last).to eq 0
      end
    end
  end
end
