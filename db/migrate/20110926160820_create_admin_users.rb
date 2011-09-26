class CreateAdminUsers < ActiveRecord::Migration
  def up
    create_table :admins do |t|
      t.database_authenticatable
      t.lockable
      t.trackable
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
