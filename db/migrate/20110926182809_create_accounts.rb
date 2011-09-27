class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :domain

      t.integer :plan_id
      t.timestamps
    end
  end
end
