class Account < ActiveRecord::Base
  belongs_to :plan
  has_many :users
  has_many :admins
  accepts_nested_attributes_for :users
  accepts_nested_attributes_for :admins

  validates_presence_of :admins
  validates_presence_of :plan
end
