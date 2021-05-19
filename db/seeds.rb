# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

grannyG = User.create(email: "a@b.c", password: "123456", street_number: "69 - 75 Duncan Road", postcode: "4157", suburb: "Sheldon", state: "QLD", name: "Granny G")
grannyB = User.create(email: "a@b.com", password: "123456", street_number: "69 - 75 Duncan Road", postcode: "4157", suburb: "Sheldon", state: "QLD", name: "Granny B")

grannyG.add_role(:grandma)
