module ItemsHelper
  def get_available_boxes(item)
    Box.all.map {|box| box.name}.select {|x| x != item.box.name}
  end
end
