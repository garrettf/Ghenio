class LoginsController < ApplicationController
  EVERNOTE_CALLBACK_URL = 'http://localhost:3000/callbacks/evernote'
  def evernote
    request_token = EvernoteClient.new.request_token(
      oauth_callback: EVERNOTE_CALLBACK_URL
    )
    session[ :evernote_request_token ] = request_token
    redirect_to request_token.authorize_url
  end
end
