FactoryBot.define do
  factory :medicine do
    name { 'benegripe' }
    value { 20.00 }
    quantity { 8 }
    stock { 10 }
  end
end