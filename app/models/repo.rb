class Repo < ActiveRecord::Base
  has_one :synchronization
  validates_presence_of :name
end
