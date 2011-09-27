class CreateSubscriptionPayments < ActiveRecord::Migration
  def change
    create_table :subscription_payments do |t|
      t.float :amount
      t.integer :subscription_id
      t.integer :account_id
      t.string :transaction_id


      t.timestamps
    end
  end
end
