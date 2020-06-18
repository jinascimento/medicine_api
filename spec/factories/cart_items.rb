FactoryBot.define do
  factory :cart_item do
    quantity { 5 }
    price { 10.00 }
    medicine
    cart
  end
end
