require 'rails_helper'

RSpec.describe MedicineManager::MedicineCreator, type: :service do
  describe '#call' do
    context 'when valid medicine' do
      it 'returns medicine object persisted' do
        medicine = FactoryBot.attributes_for(:medicine)
        result = described_class.call(medicine)

        expect(result.persisted?).to be_truthy
      end
    end

    context 'when invalid medicine' do
      it 'return exception' do
        medicine = FactoryBot.attributes_for(:medicine, name: nil)
        expect { described_class.call(medicine) }
            .to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

end