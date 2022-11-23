# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

=begin
for i in 1..30
  user = User.new
  user.email = "user#{i}@email.com"
  user.password = '12345678'
  user.save!
end
=end

for i in 1..30
  user = User.where(email: "user#{i}@email.com").first
  Article.create(user_id: user.id, title: "title#{i}", content: "content of article #{i}")
end
