class CreateTimelines < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :timelines, id: :uuid do |t|
      t.string :title, null: false
      t.text :body, null: false

      t.timestamps null: false
    end
  end
end
