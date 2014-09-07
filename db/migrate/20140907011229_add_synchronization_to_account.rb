class AddSynchronizationToAccount < ActiveRecord::Migration
  def change
    add_reference :synchronizations, :account, index: true
  end
end
