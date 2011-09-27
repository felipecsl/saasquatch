class Account < ActiveRecord::Base
  belongs_to :plan
  has_many :users
  has_many :admins
  accepts_nested_attributes_for :users

  validates_presence_of :users
  validates_presence_of :plan
end
