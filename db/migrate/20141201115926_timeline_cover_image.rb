class TimelineCoverImage < ActiveRecord::Migration
  def change
    change_table :timelines do |t|
      t.string :cover_image
      t.string :cover_image_caption
      t.string :cover_image_credit
    end
  end
end
