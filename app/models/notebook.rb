class Notebook < ActiveRecord::Base
  has_many :synchronizations
end
