class Medicine < ApplicationRecord
  validates :value, presence: true

  def total
    value * quantity
  end
end
