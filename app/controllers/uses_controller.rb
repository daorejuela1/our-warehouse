class UsesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    unless @item.user.nil?
      redirect_to request.referrer, alert: "This Item has not been returned"
      return
    end
    current_user.items.append(@item)
    if @current_user.save
      redirect_to @item.box, notice: "Take care of your new item"
    end
  end

  def destroy
    @item = current_user.items.find_by(id: params[:id])
    if @item.user.nil?
      redirect_to request.referrer, alert: "This Item has not been borrowed"
      return
    end
    current_user.items.delete(@item)
    if @current_user.save
      redirect_to @item.box, notice: "Thanks for returning the item"
    end
  end
end
