class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_items, dependent: :destroy

  accepts_nested_attributes_for :cart_items
end
