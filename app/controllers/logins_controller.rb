class LoginsController < ApplicationController
  before_filter :authenticate

  EVERNOTE_CALLBACK_URL = 'http://localhost:3000/callbacks/evernote'
  GITHUB_CALLBACK_URL = 'http://localhost:3000/callbacks/github'
  GITHUB_SCOPES = 'repo'

  def evernote
    request_token = EvernoteClient.new.request_token(
      oauth_callback: EVERNOTE_CALLBACK_URL
    )
    session[ :evernote_request_token ] = request_token
    redirect_to request_token.authorize_url
  end

  def github
    params = {
      client_id: ENV.fetch('GITHUB_CLIENT_ID'),
      redirect_uri: GITHUB_CALLBACK_URL,
      scope: GITHUB_SCOPES,
      state: current_account.id
    }
    redirect_to 'https://github.com/login/oauth/authorize?' + CGI.unescape(params.to_query)
  end

  def disconnect

  end
end
