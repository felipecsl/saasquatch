class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.float :amount
      t.datetime :next_renewal_at
      t.string :card_number
      t.string :card_expiration
      t.string :state

      t.timestamps
    end
  end
end
