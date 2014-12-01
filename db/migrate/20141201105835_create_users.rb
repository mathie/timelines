class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :name, null: false
      t.string :email_address, null: false

      t.timestamps null: false
    end

    add_index :users, :email_address, unique: true
  end
end
