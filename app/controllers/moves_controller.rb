class MovesController < ApplicationController
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

end
