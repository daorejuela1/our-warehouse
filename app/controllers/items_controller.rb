class ItemsController < ApplicationController
  def new
    box = Box.find(params[:box_id])
    @items = box.items.build
  end

  def create
    box = Box.find(params[:box_id])
    @items = box.items.build(items_params)
    if @items.save
      redirect_to box_path(box), notice: 'Added new item'
    else
      render :new
    end
  end

  def destroy

  end

  def items_params
    params.require(:item).permit(:description, :picture)
  end
end
