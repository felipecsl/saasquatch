class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :domain
      t.integer :plan_id
      t.string :card_number
      t.integer :card_expiration_month
      t.integer :card_expiration_year
      t.string :card_holder
      t.string :card_security_code

      t.timestamps
    end
  end
end
