require 'rails_helper'

RSpec.describe DiscountPlan, type: :model do

  context 'table fields' do
    it { is_expected.to have_db_column(:percentage).of_type(:float) }
    it { is_expected.to have_db_column(:different_item).of_type(:integer) }
  end
end
