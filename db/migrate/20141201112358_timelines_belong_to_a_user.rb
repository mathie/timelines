class TimelinesBelongToAUser < ActiveRecord::Migration
  def change
    change_table :timelines do |t|
      t.uuid :user_id, null: false, default: User.first.id
    end

    add_index :timelines, :user_id
    add_foreign_key :timelines, :users, on_delete: :restrict, on_update: :restrict

    change_column_default :timelines, :user_id, nil
  end
end
