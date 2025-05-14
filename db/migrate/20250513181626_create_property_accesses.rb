class CreatePropertyAccesses < ActiveRecord::Migration[7.2]
  def change
    create_table :property_accesses do |t|
      t.references :property, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
