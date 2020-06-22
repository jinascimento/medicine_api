# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts '********************************************'
puts 'Populando tabela de plano de descontos'

discount_plan = [
  { percentage: 5,  different_item: 2 },
  { percentage: 10, different_item: 3 },
  { percentage: 20, different_item: 4 },
  { percentage: 25, different_item: 5 }
]
discount_plan.each do |plan|
  DiscountPlan.create(plan)
end

puts '********************************************'
puts 'Planos de desconto criado'

puts '********************************************'
puts 'Populando tabela customer'

Customer.create(name: 'Joselito')

puts '********************************************'
puts 'Customer criado'

puts '********************************************'
puts 'Populando tabela medicine'

medicine = [
  { name: 'aspirina', value: 8.00, quantity: 2, stock: 2 },
  { name: 'enxaq', value: 8.00, quantity: 2, stock: 2 },
  { name: 'engov', value: 8.00, quantity: 2, stock: 2 },
  { name: 'doril', value: 8.00, quantity: 1, stock: 1 },
  { name: 'viagra', value: 8.00, quantity: 1, stock: 1 },
]

medicine.each do |med|
  Medicine.create(med)
end

puts '********************************************'
puts 'Medicine criada'
