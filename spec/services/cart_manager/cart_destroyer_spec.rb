require 'rails_helper'

RSpec.describe CartManager::CartDestroyer, type: :service do
  describe '#call' do
    context 'when found cart' do
      it 'returns true' do
        cart = FactoryBot.create(:cart)

        result = described_class.call(cart)
        expect(result).to be_truthy
      end
    end
  end

end