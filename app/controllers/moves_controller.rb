class MovesController < ApplicationController
  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    new_box = Box.find_by(name: params[:item][:box])
    @item.box = new_box
    if @item.save
      redirect_to new_box, notice: 'Item moved'
    else
      render :edit
    end
  end

end
