class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.references :customer, foreign_key: true
      t.decimal :total_amount, null: false, precision: 15, scale: 2
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
