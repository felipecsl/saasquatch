class Account < ActiveRecord::Base
  belongs_to :plan
  has_many :users
  has_many :subscription_payments
  accepts_nested_attributes_for :users

  validates_presence_of :users, :plan, :name, :domain
end
