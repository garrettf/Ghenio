class AddSynchronizationToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :synchonization, index: true
  end
end
