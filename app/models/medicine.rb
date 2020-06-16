class Medicine < ApplicationRecord
  validates :value, presence: true
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  def total
    value * quantity
  end
end
