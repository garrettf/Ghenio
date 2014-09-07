class Synchronization < ActiveRecord::Base
  belongs_to :notebook
  belongs_to :repo
  belongs_to :account
end
