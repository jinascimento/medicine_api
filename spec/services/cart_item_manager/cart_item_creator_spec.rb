require 'rails_helper'

RSpec.describe CartItemManager::CartItemCreator, type: :service do
  describe '#call' do
    context 'valid params' do
      it 'return new cart item' do
        cart = FactoryBot.create(:cart, status: 'opened')
        medicine = FactoryBot.create(:medicine)
        cart_item = FactoryBot.attributes_for(:cart_item, cart_id: cart.id,
                                              quantity: 5, medicine_id: medicine.id)

        cart_item_adder = described_class.new(cart, cart_item)
        cart_item_adder.call

        expect(cart_item_adder.item).to be_a CartItem
      end

      it 'decreases the number of items that have just been created from the stock' do
        cart = FactoryBot.create(:cart, status: 'opened')
        medicine = FactoryBot.create(:medicine, stock: 5)
        cart_item = FactoryBot.attributes_for(:cart_item,
                                              cart_id: cart.id,
                                              quantity: 3,
                                              medicine_id: medicine.id)

        item_build = described_class.new(cart, cart_item)
        item_build.call

        medicine.reload
        expect(medicine.stock).to eq(2)
      end
    end
  end

end