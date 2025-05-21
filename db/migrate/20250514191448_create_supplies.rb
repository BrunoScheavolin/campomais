class CreateSupplies < ActiveRecord::Migration[7.2]
  def change
    create_table :supplies do |t|
      t.string :name
      t.integer :quantity
      t.decimal :expense
      t.references :animal_production, foreign_key: true, null: true
      t.timestamps
    end
  end
end
