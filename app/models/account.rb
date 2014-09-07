class Account < ActiveRecord::Base
  model_name.instance_variable_set(:@route_key, 'account')

  has_secure_password
  has_one :evernote_access_token
  has_one :github_access_token
end
