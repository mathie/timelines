class CreateEras < ActiveRecord::Migration
  def change
    create_table :eras, id: :uuid do |t|
      t.date :started_on, null: false
      t.date :ended_on, null: false
      t.string :title, null: false
      t.text :body
      t.uuid :timeline_id

      t.timestamps null: false
    end

    add_index :eras, :timeline_id
    add_foreign_key :eras, :timelines, on_update: :restrict, on_delete: :restrict
  end
end
