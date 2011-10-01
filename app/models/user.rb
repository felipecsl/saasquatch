class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  belongs_to :account
  has_one :role

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :role, :email, :password, :password_confirmation, :remember_me, :account, :account_id

  validates_presence_of :role

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else # Create a user with a stub password.
      User.create(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  def admin?
    role.name == "admin"
  end

  def superuser?
    role.name == "superuser"
  end
end
