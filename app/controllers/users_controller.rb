#coding: utf-8
class UsersController < ApplicationController
  check_authorization
  load_and_authorize_resource except: [:edit, :update]
  skip_authorization_check :only => [:edit, :update]
  before_filter :authorized_to_edit_user, only: [:edit, :update]

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def index
    @account = Account.find(params[:account_id])
    @users = User.where(account_id: @account.id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Usuário #{@user.name} criado com sucesso."
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      flash[:notice] = "Usuário #{@user.name} atualizado com sucesso."
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Usuário removido com sucesso."
      redirect_to root_path
    end
  end

  private
  def authorized_to_edit_user
    unauthorized = !current_user || current_user.id.to_s != params[:id]
    if cannot?(:manage, User) && unauthorized
      flash[:error] = "Você não está autorizado a acessar esta página"
      redirect_to root_url
    end
  end
end
