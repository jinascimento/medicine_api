require 'rails_helper'

RSpec.describe CartManager::CartDestroyer, type: :service do
  describe '#call' do
    context 'valid cart' do
      it 'destroy cart' do
        cart = FactoryBot.create(:cart, status: 'opened')

        expect { described_class.call(cart) }
            .to change(Cart, :count).by(-1)
      end

      it 'return items to stock' do
        cart = FactoryBot.create(:cart, status: 'opened')
        medicine = FactoryBot.create(:medicine, stock: 0)
        FactoryBot.create(:cart_item,
                          cart_id: cart.id,
                          medicine_id: medicine.id,
                          quantity: 3)


        described_class.call(cart)
        medicine.reload
        expect(medicine.stock).to eq(3)
      end
    end
  end

end