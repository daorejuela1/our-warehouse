class AddCurrentPlanToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :current_plan, :string
  end
end
