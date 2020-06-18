class CreateMedicines < ActiveRecord::Migration[5.2]
  def change
    create_table :medicines do |t|
      t.string :name, null: false
      t.decimal :value, null: false, default: 0, precision: 15, scale: 2
      t.integer :quantity, default: 0
      t.integer :stock, default: 0

      t.timestamps
    end
  end
end
