class Repo < ActiveRecord::Base
  has_many :synchronizations
  validates_presence_of :name
end
