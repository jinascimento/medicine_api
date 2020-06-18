require 'rails_helper'

RSpec.describe CartItemManager::BuildCartItem, type: :service do
  describe '#call' do
    context 'valid params' do
      it 'when the the medicine already on cart return the cart item' do
        cart = FactoryBot.create(:cart, status: 'opened')
        cart_item = FactoryBot.create(:cart_item, cart_id: cart.id)

        cart_item_attributes = { medicine_id: cart_item.medicine_id, quantity: 2 }
        item_build = described_class.new(cart, cart_item_attributes)
        item_build.call

        expect(item_build.item.persisted?).to be_truthy
      end

      it 'when the item no exist build new item' do
        cart = FactoryBot.create(:cart, status: 'opened')
        medicine = FactoryBot.create(:medicine)
        cart_item = FactoryBot.attributes_for(:cart_item, cart_id: cart.id, quantity: 3, medicine_id: medicine.id)

        item_build = described_class.new(cart, cart_item)
        item_build.call
        expect(item_build.item.new_record?).to be_truthy
      end
    end
  end

end