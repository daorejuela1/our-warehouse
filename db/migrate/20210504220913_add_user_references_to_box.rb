class AddUserReferencesToBox < ActiveRecord::Migration[6.1]
  def change
    add_reference :boxes, :user, null: false, foreign_key: true
  end
end
