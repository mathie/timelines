class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :body
      t.date :started_on, null: false
      t.date :ended_on
      t.uuid :timeline_id, null: false
      t.uuid :category_id, null: false

      t.timestamps null: false
    end

    add_index :events, :category_id
    add_index :events, :timeline_id

    add_foreign_key :events, :categories, on_update: :restrict, on_delete: :restrict
    add_foreign_key :events, :timelines, on_update: :restrict, on_delete: :restrict
  end
end
