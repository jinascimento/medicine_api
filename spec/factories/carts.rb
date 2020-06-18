FactoryBot.define do
  factory :cart do
    customer
    total_amount { 10 }
  end
end