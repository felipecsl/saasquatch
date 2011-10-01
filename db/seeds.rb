# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p0 = Plan.create(name: "Free", price: 0)
p1 = Plan.create(name: "Basic", price: 10)
p2 = Plan.create(name: "Premium", price: 30)

admin = Role.create(name: "admin")
superuser = Role.create(name: "superuser")

User.create(name: "Admin User", email: "felipe.lima@noitehoje.com.br", role: superuser, password: "654321")

acct = Account.create(
  name: "Test account",
  domain: "test",
  plan: p1,
  users: [User.new(
    name: "Felipe Lima",
    email: "felipe.lima@gmail.com",
    role: admin,
    password: "123456")])
