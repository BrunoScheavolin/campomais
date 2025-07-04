class CreateProperties < ActiveRecord::Migration[7.2]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :address
      t.string :size
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
