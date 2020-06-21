require 'rails_helper'

RSpec.describe CartItemManager::CartItemAdder, type: :service do
  describe '#call' do
    context 'valid params' do
      it 'increment quantity' do
        cart = FactoryBot.create(:cart, status: 'opened')
        cart_item = FactoryBot.create(:cart_item, cart_id: cart.id, quantity: 5)

        cart_item_attributes = { medicine_id: cart_item.medicine_id, quantity: 2 }
        cart_item_adder = described_class.call(cart, cart_item_attributes)

        expect(cart_item_adder.quantity).to eq(7)
      end

      it 'decreases stock items that have been added to the cart' do
        cart = FactoryBot.create(:cart, status: 'opened')
        medicine = FactoryBot.create(:medicine, stock: 10)
        cart_item = FactoryBot.create(:cart_item,
                                      cart_id: cart.id,
                                      medicine_id: medicine.id,
                                      quantity: 5)

        cart_item_attributes = { medicine_id: cart_item.medicine_id, quantity: 2 }
        described_class.call(cart, cart_item_attributes)

        medicine.reload
        expect(medicine.stock).to eq(3)
      end
    end
  end

end