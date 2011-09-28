#coding: utf-8
class AccountsController < ApplicationController
  check_authorization
  load_and_authorize_resource except: [:new, :create]
  skip_authorization_check :only => [:new, :create]
  before_filter :authenticate_user!, except: [:new, :create]

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  def new
    @plan = Plan.find_by_id(params[:plan_id])
    @account = Account.new(plan: @plan)
  end

  def create
    @account = Account.new params[:account]
    if @account.save
      flash[:notice] = 'Sua conta foi criada com sucesso!'
      redirect_to root_path
    else
      @plan = Plan.find_by_id(params[:plan_id])
      flash[:error] = 'Ocorreu um erro ao salvar a sua entrada'
      render :new
    end
  end

  def update
    if request.put?
      if @account.update_attributes(params[:account])
        flash[:notice] = 'Dados da conta alterados com sucesso.'
        redirect_to root_path
      else
        flash[:error] = 'Ocorreu um erro ao salvar a sua entrada'
        render :edit
      end
    end
  end
end
