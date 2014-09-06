class CreateEvernoteAccessTokens < ActiveRecord::Migration
  def change
    create_table :evernote_access_tokens do |t|
      t.string :token
      t.references :account

      t.timestamps
    end
  end
end
