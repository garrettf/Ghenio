class CallbacksController < ApplicationController
  # Evernote callback
  def evernote
    access_token = session[ :evernote_request_token ].get_access_token(oauth_verifier: params[:oauth_verifier])
    token = access_token.token
    session[ :evernote_access_token ] = token
    client = EvernoteClient.new token: token
    @notebooks = client.note_store.listNotebooks token
  end
end
