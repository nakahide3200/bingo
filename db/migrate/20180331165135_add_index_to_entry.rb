class AddIndexToEntry < ActiveRecord::Migration[5.1]
  def change
  	add_index 'entries', ['game_id', "user_id"], name: "index_entries_on_game_id_and_user_id", unique: true
  end
end
