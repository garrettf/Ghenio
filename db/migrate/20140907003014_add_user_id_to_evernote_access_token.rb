class AddUserIdToEvernoteAccessToken < ActiveRecord::Migration
  def change
    add_column :evernote_access_tokens, :evernote_user_id, :integer
  end
end
