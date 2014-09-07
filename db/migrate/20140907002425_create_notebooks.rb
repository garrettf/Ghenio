class CreateNotebooks < ActiveRecord::Migration
  def change
    create_table :notebooks do |t|
      t.integer :evernote_id

      t.timestamps
    end
  end
end
