class TimelinesCanBePublic < ActiveRecord::Migration
  def change
    change_table :timelines do |t|
      t.boolean :public, null: false, default: false
    end
  end
end
