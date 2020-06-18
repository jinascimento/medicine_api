require 'rails_helper'

RSpec.describe CartManager::CartLauncher, type: :service do
  describe '#call' do
    context 'valid cart' do
      it 'when will add new items on opened cart' do
        cart = FactoryBot.create(:cart, status: 'opened')
        cart_item = FactoryBot.build(:cart_item)

        expect { described_class.call(cart.customer, cart_item.attributes) }
          .to change(Cart.find(cart.id).cart_items, :count).by(+1)
      end

      it 'when will add quantity to item on cart' do
        cart = FactoryBot.create(:cart, status: 'opened')
        cart_item = FactoryBot.create(:cart_item, cart_id: cart.id, quantity: 3)

        attributes = { medicine_id: cart_item.medicine_id, quantity: 1 }

        described_class.call(cart.customer, attributes)
        cart_item.reload
        expect(cart_item.quantity).to eq(4)
      end
    end
  end

end