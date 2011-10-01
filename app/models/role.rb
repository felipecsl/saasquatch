class Role < ActiveRecord::Base
  ROLES = {
    admin: "admin",
    superuser: "superuser"
  }

  belongs_to :user

  validates_presence_of :name
end
