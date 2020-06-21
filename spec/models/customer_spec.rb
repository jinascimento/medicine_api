require 'rails_helper'

RSpec.describe Customer, type: :model do
  context 'relationships' do
    it { is_expected.to have_many :carts }
  end

  context 'table fields' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end
end
