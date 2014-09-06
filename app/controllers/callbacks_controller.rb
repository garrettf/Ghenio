class CallbacksController < ApplicationController
  before_filter :authenticate
  # Evernote callback
  def evernote
    access_token = session[ :evernote_request_token ].get_access_token(oauth_verifier: params[:oauth_verifier])
    token = access_token.token
    session[ :evernote_access_token ] = token
    EvernoteAccessToken.create! token: token, account: current_account
  end
end
