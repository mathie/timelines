class EventsWithImages < ActiveRecord::Migration
  def change
    change_table :events do |t|
      t.string :image
      t.string :image_caption
      t.string :image_credit
    end
  end
end
