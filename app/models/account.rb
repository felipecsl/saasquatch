class Account < ActiveRecord::Base
  belongs_to :plan
  has_many :users
  has_many :admins
end
