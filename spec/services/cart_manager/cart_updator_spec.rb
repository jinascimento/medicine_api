require 'rails_helper'

RSpec.describe CartManager::CartUpdator, type: :service do
  describe '#call' do
    context 'when valid cart' do
      it 'returns cart object updated' do
        customer = FactoryBot.create(:customer)
        cart = FactoryBot.create(:cart)
        attributes = { customer_id: customer.id }

        result = described_class.call(cart, attributes)
        expect(result.customer_id).to eq(attributes[:customer_id])
      end
    end

    context 'when invalid attributes' do
      it 'return exception' do
        cart = FactoryBot.create(:cart)
        attributes = { customer_id: nil }

        expect { described_class.call(cart, attributes) }
            .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

end