#coding: utf-8
class UsersController < ApplicationController
  load_and_authorize_resource

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

end
