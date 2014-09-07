class CallbacksController < ApplicationController
  before_filter :authenticate
  # Evernote callback
  def evernote
    access_token = session[ :evernote_request_token ].get_access_token(oauth_verifier: params[:oauth_verifier])
    token = access_token.token
    session[ :evernote_access_token ] = token
    EvernoteAccessToken.create! token: token, account: current_account

    client = EvernoteClient.new token: token

    redirect_to controller: "flow", action: "evernote_success"
  end

  def github
    if GithubTokenRetriever.retrieve code: params[ :code ], account_id: current_account.id
      redirect_to controller: 'flow', method: 'github_success'
    else
      flash[ :error ] = 'Github Access Token retrieval failed'
      redirect_to '/'
    end
  end
end
