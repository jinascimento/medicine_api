require 'rails_helper'

RSpec.describe MedicineManager::MedicineDestroyer, type: :service do
  describe '#call' do
    context 'when found medicine' do
      it 'returns true' do
        medicine = FactoryBot.create(:medicine)

        result = described_class.call(medicine)
        expect(result).to be_truthy
      end
    end
  end

end