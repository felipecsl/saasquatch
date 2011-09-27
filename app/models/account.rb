class Account < ActiveRecord::Base
  belongs_to :plan
  has_many :users
  accepts_nested_attributes_for :users

  validates_presence_of :users, :plan, :name, :domain
end
