class CreateDiscountPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_plans do |t|
      t.float :percentage
      t.integer :different_item
      t.timestamps
    end
  end
end
