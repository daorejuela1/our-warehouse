class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.references :box, null: false, foreign_key: true
      t.string :description
      t.boolean :status

      t.timestamps
    end
  end
end
