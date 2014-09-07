class ChangeEvernoteIdToGuid < ActiveRecord::Migration
  def change
    add_column :notebooks, :evernote_guid, :string
    remove_column :notebooks, :evernote_id
  end
end
