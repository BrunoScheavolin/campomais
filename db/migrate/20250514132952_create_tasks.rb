class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.text :description
      t.date :due_date
      t.boolean :priority
      t.boolean :uses_supplies
      t.decimal :expense
      t.text :observation
      t.string :task_type
      t.string :responsible
      t.integer :supply_id
      t.integer :supply_quantity
      t.references :animal_production, foreign_key: true, null: true

      t.timestamps
    end
  end
end
