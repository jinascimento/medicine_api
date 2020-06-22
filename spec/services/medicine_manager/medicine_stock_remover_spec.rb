require 'rails_helper'

RSpec.describe MedicineManager::MedicineStockRemover, type: :service do
  describe '#call' do
    context 'medicine stock' do
      it 'remove items stock' do
        medicine = FactoryBot.create(:medicine, stock: 2)

        described_class.call(medicine, 1)
        expect(medicine.stock).to eq(1)
      end

      it 'dont remove when not in stock' do
        medicine = FactoryBot.create(:medicine, stock: 3)

        expect { described_class.call(medicine, 4) }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

end