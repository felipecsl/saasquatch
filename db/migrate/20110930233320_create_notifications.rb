class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :account_id
      t.integer :trigger_id

      t.timestamps
    end
  end
end
