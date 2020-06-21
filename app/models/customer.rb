class Customer < ApplicationRecord
  has_many :carts, dependent: :nullify
end
