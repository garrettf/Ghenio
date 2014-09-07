class CreateSynchronizations < ActiveRecord::Migration
  def change
    create_table :synchronizations do |t|
      t.references :notebook, index: true
      t.references :repo, index: true

      t.timestamps
    end
  end
end
