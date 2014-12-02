class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations, id: :uuid do |t|
      t.string :email_address, null: false
      t.uuid :timeline_id, null: false

      t.timestamps null: false
    end

    add_index :invitations, :timeline_id
    add_foreign_key :invitations, :timelines, on_update: :restrict, on_delete: :restrict
  end
end
