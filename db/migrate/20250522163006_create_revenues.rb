class CreateRevenues < ActiveRecord::Migration[7.2]
  def change
    create_table :revenues do |t|
      t.string :description
      t.references :animal_production, null: false, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
