module ApplicationHelper
  include Pagy::Frontend
  def link_to_add_fields(name, form, association, **args)
    new_object = form.object.send(association).klass.new
    id = new_object.object_id
    fields = form.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', builder: builder)
    end
    link_to(name, '#', class: 'add_fields ' + args[:class], data: { id: id, fields: fields.gsub("\n", '') })
  end
end
