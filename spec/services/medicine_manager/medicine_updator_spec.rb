require 'rails_helper'

RSpec.describe MedicineManager::MedicineUpdator, type: :service do
  describe '#call' do
    context 'when valid medicine' do
      it 'returns medicine object updated' do
        medicine = FactoryBot.create(:medicine)
        attributes = { name: Faker::Name.name }

        result = described_class.call(medicine, attributes)
        expect(result.name).to eq(attributes[:name])
      end
    end

    context 'when invalid attributes' do
      it 'return exception' do
        medicine = FactoryBot.create(:medicine)
        attributes = { name: nil }

        expect { described_class.call(medicine, attributes) }
            .to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

end