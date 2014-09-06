class AccountsController < ApplicationController
  def create
    @account = Account.new new_account_params
    if @account.save
      flash[ :success ] = 'Account created successfully'
    else
      flash[ :error ] = 'Account creation failed.'
    end
  end

  def login
    # TODO: catch find by's exception
    if account = Account.find_by( email: login_params[ :email ] ).try(
      :authenticate,
      login_params[ :password ]
    )
      session[ :account_id ] = account.id
      flash[ :success ] = 'Login succeeded!'
      redirect_to '/'
      # redirect_to somewhere
    else
      flash[ :error ] = 'Login failed.'
      redirect_to :back
    end
  end

  private

  def new_account_params
    params.require( :account ).permit( :email, :password, :password_confirmation )
  end

  def login_params
    params.require( :account ).permit( :email, :password )
  end
end
