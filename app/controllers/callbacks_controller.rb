class CallbacksController < ApplicationController
  # Evernote callback
  def en
    client = EvernoteOAuth::Client.new token: params[ :oauth_token ]
  end
end
