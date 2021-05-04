class BoxesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @boxes = pagy(Box.all)
  end

  def show
  end

  def new
    @box = current_user.boxes.new
  end

  def create
    @box = current_user.boxes.new(box_params)
    if @box.save
      redirect_to root_path, notice: 'Succesfully created box'
    else
      render :new
    end
  end

  private

  def box_params
    params.require(:box).permit(:name)
  end
end
