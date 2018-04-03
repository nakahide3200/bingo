class CreateCard < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.references :entry, null:false
      t.text :numbers, null: false
    end
  end
end
