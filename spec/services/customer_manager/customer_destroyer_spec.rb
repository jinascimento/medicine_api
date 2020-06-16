require 'rails_helper'

RSpec.describe CustomerManager::CustomerDestroyer, type: :service do
  describe '#call' do
    context 'when found customer' do
      it 'returns true' do
        customer = FactoryBot.create(:customer)

        result = described_class.call(customer)
        expect(result).to be_truthy
      end
    end
  end

end