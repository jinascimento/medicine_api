require 'rails_helper'

RSpec.describe CustomerManager::CustomerUpdator, type: :service do
  describe '#call' do
    context 'when valid customer' do
      it 'returns customer object updated' do
        customer = FactoryBot.create(:customer)
        attributes = { name: Faker::Name.name }

        result = described_class.call(customer, attributes)
        expect(result.name).to eq(attributes[:name])
      end
    end

    context 'when invalid attributes' do
      it 'return exception' do
        customer = FactoryBot.create(:customer)
        attributes = { name: nil }

        expect { described_class.call(customer, attributes) }
            .to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

end