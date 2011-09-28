class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_account

  def load_account
    @account = current_user.account if current_user
    @account = Account.find(params[:account_id]) if params[:account_id]
    @account_name = @account ? @account.name : "Site Name"
  end
end
