FactoryBot.define do
  factory :cart_item do
    quantity { 5 }
    medicine
    cart
  end
end
