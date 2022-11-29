@user1 = User.create(email: "test@test.com", name:"Test", password:"qwe123", password_confirmation:"qwe123")

49.times do
    User.create(email: Faker::Internet.email, name: Faker::Name.name, password:"qwe123", password_confirmation:"qwe123")
end

250.times do
    Post.create(name: Faker::Lorem.word, text: Faker::Lorem.sentence, user_id: (1 + Random.rand(49)))
end

500.times do
    Like.create(user_id: (1 + Random.rand(49)), post_id: (1 + Random.rand(249)))
end