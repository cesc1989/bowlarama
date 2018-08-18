RSpec.describe Bowlarama::Game do
  describe 'Constants' do
    it 'has a strike sign as constant' do
      expect(Bowlarama::Game::STRIKE_SIGN).to eq 'X'
    end

    it 'has a spare sign as constant' do
      expect(Bowlarama::Game::SPARE_SIGN).to eq '/'
    end
  end
end
