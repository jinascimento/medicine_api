require 'rails_helper'

RSpec.describe Calcs::CartCalc, type: :calc do
  context '#total_amount' do
    it 'Total amount cart is equal total price of cart items' do
      cart = FactoryBot.create(:cart)
      FactoryBot.create(:cart_item, price: 20, cart_id: cart.id)

      result = described_class.new(cart).total_amount

      expect(result).to eq(20)
    end

    it 'Total amount cart with discount of 5% when medicines items different' do
      FactoryBot.create(:discount_plan, percentage: 5, different_item: 2)
      cart = FactoryBot.create(:cart)
      doril = FactoryBot.create(:medicine, value: 10.00)
      benegripe = FactoryBot.create(:medicine, value: 20.00)
      FactoryBot.create(:cart_item,
                        price: 10.00,
                        quantity: 1,
                        medicine_id: doril.id,
                        cart_id: cart.id)

      FactoryBot.create(:cart_item,
                        price: 20.00,
                        quantity: 1,
                        medicine_id: benegripe.id,
                        cart_id: cart.id)

      result = described_class.new(cart).total_amount_with_discount

      # 10 + 20 = 30
      # 30 * 0.5 = 1.5 de desconto
      # 30 - 1.5 = 28.50
      expect(result.to_f).to eq(28.50)
    end


  end

end