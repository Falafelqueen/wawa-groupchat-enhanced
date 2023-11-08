# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "Cleaning up the database"

Message.destroy_all
Chatroom.destroy_all
User.destroy_all

puts "Creating users..."

User.create!(email: "linda@linda.com", password: "123456", password_confirmation: "123456", display_name: "Linda")
User.create!(email: "kevin@kevin.com", password: "123456", password_confirmation: "123456", display_name: "Kevin")
User.create!(email: "nero@nero.com", password: "123456", password_confirmation: "123456", display_name: "Nero")
User.create!(email: "terry@terry.com", password: "123456", password_confirmation: "123456", display_name: "Terry")

puts "Creating chatrooms..."

snacks = Chatroom.create!(name: "Favorite snacks 🦴🍖")
walks = Chatroom.create!(name: "Walks 🪃")
cats = Chatroom.create!(name: "Cats suck 🐈 🚫")

puts "Creating messages..."

Message.create!(text: "I love bones!", user: User.all.sample, chatroom: snacks)
Message.create!(text: "I love trash!", user: User.all.sample, chatroom: snacks)
Message.create!(text: "Cats are not as cool!", user: User.all.sample, chatroom: cats)
Message.create!(text: "Well said, you!", user: User.all.sample, chatroom: cats)

puts "Created #{User.count} users and #{Chatroom.count} chatrooms with #{Message.count} messages."
