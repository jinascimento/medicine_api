require 'rails_helper'

RSpec.describe Calcs::CartItemCalc, type: :calc do
  context '#price' do
    it 'price cart item' do
      quantity = 5
      medicine_value = 20
      medicine = FactoryBot.create(:medicine, value: medicine_value)
      cart_item = FactoryBot.create(:cart_item, quantity: quantity, medicine_id: medicine.id)

      price = quantity * medicine_value
      result = described_class.new(cart_item).price

      expect(result).to eq(price)
    end

  end

end