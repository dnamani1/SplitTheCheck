# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Restaurant.delete_all

Restaurant.create!(name: 'Blockbuster Restaurant & Bar', address: '5158 McGinnis Ferry Rd', city: 'Alpharetta', state: 'GA', zip: '30005')

Restaurant.create!(name: 'Olive Garden', address: '3565 Mall Blvd NW', city: 'Duluth', state: 'GA', zip: '30096')

Restaurant.create!(name: 'Dominos Pizza', address: '12460 Crabapple Rd 102 Ste 102', city: 'Alphareeta', state: 'GA', zip: '30004')

Restaurant.create!(name: 'House Spun Restaurant', address: '5192 Nelson Brogdon Blvd suite 500', city: 'Sugar Hill', state: 'GA', zip: '30518')

