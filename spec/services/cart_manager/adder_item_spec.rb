require 'rails_helper'

RSpec.describe CartManager::AdderItem, type: :service do
  describe '#call' do
    context 'when valid cart item' do
      it 'returns cart object persisted' do
        customer = FactoryBot.create(:customer)
        medicine = FactoryBot.create(:medicine)
        cart_item = FactoryBot.attributes_for(:cart_item, medicine_id: medicine.id)
        result = described_class.call(customer, cart_item)

        expect(result.persisted?).to be_truthy
      end

      it 'subtract from the medication stock the quantity of items added to the cart' do
        customer = FactoryBot.create(:customer)
        medicine = FactoryBot.create(:medicine, stock: 5)
        cart_item = FactoryBot.attributes_for(:cart_item, medicine_id: medicine.id, quantity: 2)

        described_class.call(customer, cart_item)
        medicine.reload
        expect(medicine.stock).to eq(3)
      end

      it 'add item quantity to cart when cart already has medicine' do
        medicine = FactoryBot.create(:medicine, stock: 5)
        cart = FactoryBot.create(:cart)
        cart_item = FactoryBot.create(:cart_item, medicine_id: medicine.id, quantity: 4, cart_id: cart.id)

        cart_item_attributes = { medicine_id: cart_item.medicine_id, quantity: 2 }
        described_class.call(cart.customer, cart_item_attributes)
        cart_item.reload
        expect(cart_item.quantity).to eq(6)
      end
    end

  end

end