require 'rails_helper'

RSpec.describe MedicineManager::MedicineStockAdder, type: :service do
  describe '#call' do
    context 'medicine stock' do
      it 'returns items to stock' do
        medicine = FactoryBot.create(:medicine, stock: 2)

        described_class.call(medicine, 3)
        expect(medicine.stock).to eq(5)
      end
    end
  end

end