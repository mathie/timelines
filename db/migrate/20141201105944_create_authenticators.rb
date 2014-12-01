class CreateAuthenticators < ActiveRecord::Migration
  def change
    create_table :authenticators, id: :uuid do |t|
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :token
      t.string :secret
      t.uuid :user_id, null: false

      t.timestamps null: false
    end

    add_index :authenticators, :user_id
    add_index :authenticators, [:provider, :uid], unique: true

    add_foreign_key :authenticators, :users, on_delete: :restrict, on_update: :restrict
  end
end
