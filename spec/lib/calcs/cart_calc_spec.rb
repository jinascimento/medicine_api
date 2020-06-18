require 'rails_helper'

RSpec.describe Calcs::CartCalc, type: :calc do
  context '#total_amount' do
    it 'Total amount cart is equal total price of cart items' do
      cart = FactoryBot.create(:cart)
      FactoryBot.create(:cart_item, price: 20, cart_id: cart.id)

      result = described_class.new(cart).total_amount

      expect(result).to eq(20)
    end

  end

end