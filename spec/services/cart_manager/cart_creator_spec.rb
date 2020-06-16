require 'rails_helper'

RSpec.describe CartManager::CartCreator, type: :service do
  describe '#call' do
    context 'when valid cart' do
      it 'returns cart object persisted' do
        customer = FactoryBot.create(:customer)
        cart = FactoryBot.attributes_for(:cart)
        result = described_class.call(customer, cart)

        expect(result.persisted?).to be_truthy
      end
    end

  end

end