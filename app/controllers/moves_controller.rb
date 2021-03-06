class MovesController < ApplicationController
  set_current_tenant_through_filter
  before_action :authenticate_user!
  before_action :set_tenant_item, only: :edit
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    new_box = Box.find_by(name: params[:item][:box])
    if @item.update(box: new_box)
      redirect_to new_box, notice: 'Item moved'
    else
      errors_bk = @item.errors[:box]
      @item = Item.find(params[:id])
      @item.errors.add(:box, errors_bk)
      render :edit
    end
  end

  private

  def set_tenant_item
    ActsAsTenant.without_tenant do
      @item = Item.find(params[:id])
      @account_name = @item.box.account.name
      @account = @item.box.account
    end
    if current_user.tenant_list.include? (@account_name)
      if ActsAsTenant.current_tenant != @account
        current_user.update!(selected_tenant: @account_name)
        set_current_tenant(@account)
      end
    else
      redirect_to root_path, alert: 'You are not part of that team'
    end
  end

end
