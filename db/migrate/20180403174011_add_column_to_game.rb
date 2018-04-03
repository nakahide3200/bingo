class AddColumnToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :numbers, :text, null: false, default: ''
  end
end
