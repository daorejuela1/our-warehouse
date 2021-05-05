class BoxesController < ApplicationController
  set_current_tenant_through_filter
  before_action :set_tenant, only: :show

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

  def set_tenant
    ActsAsTenant.without_tenant do
      @box = Box.find(params[:id])
    end
    if current_user.tenant_list.include? (@box.account.name)
      current_user.update!(selected_tenant: @box.account.name)
      set_current_tenant(@box.account)
    else
      redirect_to root_path, alert: 'You are not part of that team'
    end
  end
end
