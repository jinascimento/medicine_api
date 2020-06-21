require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'relationships' do
    it { is_expected.to belong_to :customer }
  end

  context 'table fields' do
    it { is_expected.to have_db_column(:customer_id).of_type(:integer) }
    it { is_expected.to have_db_column(:status).of_type(:integer) }
    it { is_expected.to have_db_column(:total_amount).of_type(:decimal) }
  end
end
