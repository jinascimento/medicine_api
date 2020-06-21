require 'rails_helper'

RSpec.describe Medicine, type: :model do

  context 'table fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:value).of_type(:decimal) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_column(:stock).of_type(:integer) }
  end

  context '#total' do
    it 'multiplies' do
      valid_attributes = { name: 'Aspirina', value: 10.0, quantity: 1, stock: 10 }
      medicine = Medicine.new(valid_attributes)
      expect(medicine.total).to eql 10.0
    end
  end
end
