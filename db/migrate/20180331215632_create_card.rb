class CreateCard < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :entry, null:false
      t.text :serialized_numbers, null: false
    end
  end
end
