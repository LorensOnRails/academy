class Admin::AccountsController < ApplicationController
  before_action :authenticate_admin!

  layout "admin"
  
  def show
    @account = Account.find(params[:id])
  end

  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(admin_account_params)
      flash[:notice] = 'Changes updated successfully!'
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = 'Could not update, Please try again'
      render :edit, alert: "Could not update, Please try again"
    end
  end

  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to admin_accounts_url, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: [:admin,@account] }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy
    redirect_to root_url, notice: "Successfully deleted the account"
  end

  private

  def set_account
    @account = current_account
  end

  def admin_account_params
    params.require(:account).permit(:first_name, :last_name, :email, :unconfirmed_email, :image, :remove_image)
  end

end