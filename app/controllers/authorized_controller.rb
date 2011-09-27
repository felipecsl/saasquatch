class AuthorizedController < ApplicationController
  before_filter :authenticate_user!
  check_authorization
  load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
end
