class LoginsController < ApplicationController
  EVERNOTE_CALLBACK_URL = 'localhost:3000/callbacks/en'
  def evernote
    request_token = EvernoteClient.client.request_token(
      oauth_callback: EVERNOTE_CALLBACK_URL
    )
    @authorize_url = request_token.authorize_url
  end
end
