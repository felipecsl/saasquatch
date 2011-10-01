require 'spec_helper'
require "cancan/matchers"

describe User do
  it "should set correct permissions for Admin user" do
    acct = Account.new { |a| a.id = 1 }
    user = User.new(role: Role.new(name: Role::ROLES[:admin]), account: acct){ |u| u.id = 1 }
    ability = Ability.new user

    ability.should_not be_able_to(:manage, Account.new)
    ability.should be_able_to(:manage, acct)
    ability.should_not be_able_to(:manage, User.new)
    ability.should be_able_to(:manage, User.new(account: acct))
    ability.should_not be_able_to(:manage, SubscriptionPayment.new)
    ability.should be_able_to(:manage, SubscriptionPayment.new(account: acct))
  end
end
