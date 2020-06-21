require 'rails_helper'

RSpec.describe Calcs::DiscountCalc, type: :calc do
  context '#call' do
    it 'Calculates discount of two different items' do
      FactoryBot.create(:discount_plan, percentage: 5, different_item: 2)
      cart = FactoryBot.create(:cart)
      doril_price = 20.00
      doril_quantity = 1

      doril = FactoryBot.create(:medicine, value: doril_price)
      FactoryBot.create(:cart_item,
                        quantity: doril_quantity,
                        medicine_id: doril.id,
                        cart_id: cart.id)

      benegripe_price = 10.00
      benegripe_quantity = 1

      benegripe = FactoryBot.create(:medicine, value: benegripe_price)
      FactoryBot.create(:cart_item,
                        quantity: benegripe_quantity,
                        medicine_id: benegripe.id,
                        cart_id: cart.id)


      total_price_medicines = 30.00
      discount = 1.5
      28.50 # 30.00 - 1.5

      result = described_class.new(cart).call

      expect(result).to eq(28.50)
    end

    it 'return the lowest discount of three different items' do
      FactoryBot.create(:discount_plan, percentage: 10, different_item: 3)
      FactoryBot.create(:discount_plan, percentage: 5, different_item: 2)
      cart = FactoryBot.create(:cart)
      doril_price = 20.00
      doril_quantity = 1

      doril = FactoryBot.create(:medicine, value: doril_price)
      FactoryBot.create(:cart_item,
                        quantity: doril_quantity,
                        medicine_id: doril.id,
                        cart_id: cart.id,
                        price: doril.value)

      benegripe_price = 10.00
      benegripe_quantity = 1

      benegripe = FactoryBot.create(:medicine, value: benegripe_price)
      FactoryBot.create(:cart_item,
                        quantity: benegripe_quantity,
                        medicine_id: benegripe.id,
                        price: benegripe.value,
                        cart_id: cart.id)

      viagra_price = 10.00
      viagra_quantity = 1

      viagra = FactoryBot.create(:medicine, value: viagra_price)
      FactoryBot.create(:cart_item,
                        quantity: viagra_quantity,
                        medicine_id: viagra.id,
                        price: viagra.value,
                        cart_id: cart.id)


      total_price_medicines = 40.00 # 20 + 10 + 10
      discount = 4 # 10% discount
      price_with_discount = 36.00

      result = described_class.new(cart).call

      expect(result).to eq(36.00)
    end

  end

end