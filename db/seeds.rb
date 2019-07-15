# Users
User.create!(name:  "Example User",
			       username: "example-username",
             email: "example@example.com",
             password:              "foobar",
             password_confirmation: "foobar")

# Populate the database with 99 accounts
50.times do |n|
  name  = Faker::Name.name
  username = "username-#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               username: username,
               email: email,
               password:              password,
               password_confirmation: password)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

# Create some tweets
users = User.limit(10)
users.each do |user|
  tweets_content = Faker::Quote.famous_last_words
  Tweet.create!(tweet: tweets_content, user_id: user.id)
end