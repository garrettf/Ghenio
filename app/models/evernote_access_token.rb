class EvernoteAccessToken < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :token
end
