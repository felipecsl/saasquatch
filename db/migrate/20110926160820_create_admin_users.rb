class CreateAdminUsers < ActiveRecord::Migration
  def up
    create_table :admins do |t|
      t.database_authenticatable
      t.lockable
      t.trackable
      t.timestamps

      t.integer :account_id
      t.string :name
    end
  end

  def down
    drop_table :users
  end
end
