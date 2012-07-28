# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if user = User.find_by_email('admin@example.com')
  user.admin = true
  user.save
else
  User.create email: 'admin@example.com', password: 'password', admin: true
end
