class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.uuid :timeline_id, null: false

      t.timestamps null: false
    end

    add_index :categories, :timeline_id
    add_foreign_key :categories, :timelines, on_update: :restrict, on_delete: :restrict
  end
end
