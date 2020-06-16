class CreateMedicines < ActiveRecord::Migration[5.2]
  def change
    create_table :medicines do |t|
      t.string :name, null: false
      t.float :value, null: false
      t.integer :quantity
      t.integer :stock

      t.timestamps
    end
  end
end
