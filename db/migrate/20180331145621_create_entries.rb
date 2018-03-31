class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.references :user, null:false
      t.references :game, null:false 
    end
  end
end
