class CreateBoxes < ActiveRecord::Migration[6.1]
  def change
    create_table :boxes do |t|
      t.references :account, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
