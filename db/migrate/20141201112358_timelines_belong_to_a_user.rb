class TimelinesBelongToAUser < ActiveRecord::Migration
  def change
    if User.count > 0
      change_table :timelines do |t|
        t.uuid :user_id, null: false, default: User.first.id
      end

      change_column_default :timelines, :user_id, nil
    else
      change_table :timelines do |t|
        t.uuid :user_id, null: false
      end
    end

    add_index :timelines, :user_id
    add_foreign_key :timelines, :users, on_delete: :restrict, on_update: :restrict

  end
end
