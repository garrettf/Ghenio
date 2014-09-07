class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    redirect_to '/' unless authenticated?
  end

  def authenticated?
    current_account.present?
  end

  def current_account
    @current_account ||= logged_in_account
  end

  def current_evernote_client
    @evernote_client ||= EvernoteClient.new(
      token: current_account.evernote_access_token.token
    )
  end

  private

  def logged_in_account
    return if session[ :account_id ].nil?
    Account.find session[ :account_id ]
  rescue ActiveRecord::RecordNotFound
    session[ :account_id ] = nil
  end

end
