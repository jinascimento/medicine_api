require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context 'relationships' do
    it { is_expected.to belong_to :cart }
    it { is_expected.to belong_to :medicine }
  end

  context 'table fields' do
    it { is_expected.to have_db_column(:cart_id).of_type(:integer) }
    it { is_expected.to have_db_column(:medicine_id).of_type(:integer) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
    it { is_expected.to have_db_column(:price).of_type(:decimal) }
  end
end
