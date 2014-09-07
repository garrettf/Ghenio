class CreateGithubAccessTokens < ActiveRecord::Migration
  def change
    create_table :github_access_tokens do |t|
      t.string :token
      t.references :account

      t.timestamps
    end
  end
end
