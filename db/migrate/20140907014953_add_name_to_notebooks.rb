class AddNameToNotebooks < ActiveRecord::Migration
  def change
    add_column :notebooks, :name, :string
  end
end
