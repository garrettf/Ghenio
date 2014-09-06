class CallbacksController < ApplicationController
  # Evernote callback
  def evernote
    session[ :authtoken ] = request.env['omniauth.auth']['credentials']['token']
  end
end
