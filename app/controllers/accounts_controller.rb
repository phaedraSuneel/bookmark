class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /accounts
  def index
    @accounts = current_user.accounts.order('created_at desc').page(params[:page])
  end

  # GET /accounts/1
  def show
  end

  # GET /accounts/new
  def new
    @account = current_user.accounts.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  def create
    @account = current_user.accounts.new(account_params)

    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /accounts/1
  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
    redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = current_user.accounts.where(id: params[:id]).first
    end

    # Only allow a trusted parameter "white list" through.
    def account_params
      params.require(:account).permit(:name, :user_name, :email, :password, :description, :user_id)
    end
end
