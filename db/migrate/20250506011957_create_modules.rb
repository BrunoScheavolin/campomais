class CreateModules < ActiveRecord::Migration[7.2]
  def change
    create_table :production_modules do |t|
      t.string :name
      t.boolean :active
      t.json :settings
      t.integer :module_type
      t.json :production_settings
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
