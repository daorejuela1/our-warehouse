class AddSelectedTenantToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :selected_tenant, :string
  end
end
