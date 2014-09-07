class EvernoteAccessToken < ActiveRecord::Base
  belongs_to :account

  validates_presence_of :token
  validates_presence_of :evernote_user_id

  def self.create_or_update! attr = {}
    if attr[ :account ] && token = Account.find(attr[ :account ]).evernote_access_token
      token.update! attr
    else
      create! attr
    end
  end
end
