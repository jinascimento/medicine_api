# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
discount_plan = [
  { percentage: 5,  different_item: 2 },
  { percentage: 10, different_item: 3 },
  { percentage: 20, different_item: 4 },
  { percentage: 25, different_item: 5 }
]
discount_plan.each do |plan|
  DiscountPlan.create(plan)
end
