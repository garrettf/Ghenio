class Account < ActiveRecord::Base
  model_name.instance_variable_set(:@route_key, 'account')

  has_secure_password
  has_one :evernote_access_token
  has_one :github_access_token
  has_many :synchronizations

  def octokit_client
    @octokit_client ||= Octokit::Client.new( access_token: github_access_token.token )
  end

  def evernote_client
    @evernote_client ||= EvernoteClient.new token: evernote_access_token.token
  end
end
