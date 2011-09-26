class CreateSubscriptionPayments < ActiveRecord::Migration
  def change
    create_table :subscription_payments do |t|
      t.float :amount

      t.timestamps
    end
  end
end
