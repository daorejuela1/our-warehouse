class BoxesController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @boxes = pagy(Box.all)
  end

  def show
    @box = Box.find(params[:id])
    @pagy, @items = pagy(@box.items)
  end

  def new
    @box = ActsAsTenant.current_tenant.boxes.new
    @box.items.build
  end

  def create
    @box = ActsAsTenant.current_tenant.boxes.new(box_params)
    @box.user = current_user
    if @box.save
      @box.add_qr_code(request.base_url + box_path(@box))
      redirect_to root_path, notice: 'Succesfully created box'
    else
      render :new
    end
  end

  private

  def box_params
    params.require(:box).permit(:name, items_attributes: %i[id description picture _destroy])
  end
end
