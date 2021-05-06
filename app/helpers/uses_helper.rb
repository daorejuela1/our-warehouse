module UsesHelper
  def use_item_form(item)
    form_with url: uses_path, method: :post do |form|
      concat form.hidden_field(:item_id, value: item.id)
      concat form.submit("Use item", class: "form-inline btn btn-success mx-2")
    end
  end

  def return_item_form(item)
    link_to "Return", use_path(item), class: "form-inline btn btn-secondary mx-2", method: :delete
  end
end
