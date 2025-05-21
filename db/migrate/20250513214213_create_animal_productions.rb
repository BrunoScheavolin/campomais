class CreateAnimalProductions < ActiveRecord::Migration[7.2]
  def change
    create_table :animal_productions do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :breed
      t.string :purpose
      t.integer :animal_quantity
      t.string :average_weight
      t.integer :eggs_produced
      t.decimal :milk_production, precision: 10, scale: 2
      t.text :notes
      t.decimal :used_area, precision: 10, scale: 2
      t.decimal :revenue, precision: 14, scale: 2, default: 0
      t.decimal :expenses, precision: 14, scale: 2, default: 0

      t.references :production_module, null: false, foreign_key: true
      t.references :admin, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
