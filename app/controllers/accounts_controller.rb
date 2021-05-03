class AccountsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @account = current_user.account
    if @account.update(account_params)
      redirect_to root_path, notice: 'Account Updated succesfully'
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end
end
