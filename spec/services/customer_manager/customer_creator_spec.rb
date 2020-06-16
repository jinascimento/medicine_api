require 'rails_helper'

RSpec.describe CustomerManager::CustomerCreator, type: :service do
  describe '#call' do
    context 'when valid customer' do
      it 'returns customer object persisted' do
        customer = FactoryBot.attributes_for(:customer)
        result = described_class.call(customer)

        expect(result.persisted?).to be_truthy
      end
    end

    context 'when invalid customer' do
      it 'return exception' do
        customer = FactoryBot.attributes_for(:customer, name: nil)
        expect { described_class.call(customer) }
            .to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end

end