class CreateCollaborations < ActiveRecord::Migration
  class Timeline < ActiveRecord::Base
    belongs_to :user
    has_many :collaborations
  end

  def up
    create_table :collaborations, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :timeline_id, null: false

      t.timestamps null: false
    end

    add_index :collaborations, [:user_id, :timeline_id], unique: true
    add_foreign_key :collaborations, :users, on_update: :restrict, on_delete: :restrict
    add_foreign_key :collaborations, :timelines, on_update: :restrict, on_delete: :restrict

    Timeline.find_each do |timeline|
      timeline.collaborations.create!(user: timeline.user)
    end

    change_table :timelines do |t|
      t.remove :user_id
    end
  end

  def down
    change_table :timelines do |t|
      t.uuid :user_id
    end

    Timeline.find_each do |timeline|
      timeline.user = timeline.collaborations.first.user
      timeline.save!
    end

    drop_table :collaborations
  end
end
