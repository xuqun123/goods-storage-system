# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# seed users
User.create! email: 'test1@example.com', name: 'user 1', password: '123456'
User.create! email: 'test2@example.com', name: 'user 2', password: '123456'

Good.create! consignment_id: 'AS001AP', good_type: 'Food', name: 'Coconuts', source: 'Australia/Melbourne', destination: 'Australia/Adelaide', entry_date: 6.days.ago, exit_date: 5.days.ago
Good.create! consignment_id: 'AS002AP', good_type: 'Textile', name: 'Rolls of Cotton', source: 'Australia/Melbourne', destination: 'Australia/Adelaide', entry_date: 5.days.ago, exit_date: 3.days.ago
Good.create! consignment_id: 'AS003AP', good_type: 'Liquid', name: 'Edible Oil (10L)', source: 'Australia/Sydney', destination: 'Australia/Hobart', entry_date: 2.days.ago, exit_date: 1.days.ago
Good.create! consignment_id: 'AS005AP', good_type: 'Wood', name: 'Wooden Boards 20”x20', source: 'Australia/Adelaide', destination: 'Australia/Sydney', entry_date: 5.days.ago
