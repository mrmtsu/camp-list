User.create!(name:  "山田 太郎",
    email: "sample@example.com",
    password:              "foobar",
    password_confirmation: "foobar",
    admin: true)

99.times do |n|
name  = Faker::Name.name
email = "sample-#{n+1}@example.com"
password = "password"
User.create!(name:  name,
      email: email,
      password:              password,
      password_confirmation: password)
end

10.times do |n|
  Article.create!(title: Faker::Food.dish,
               description: "あったら便利グッズ！",
               reference: "https://ec.snowpeak.co.jp/snowpeak/ja/%E3%82%AD%E3%83%A3%E3%83%B3%E3%83%97/%E3%83%86%E3%83%BC%E3%83%96%E3%83%AB%E3%82%A6%E3%82%A7%E3%82%A2/%E3%83%81%E3%82%BF%E3%83%B3%E3%82%B7%E3%83%B3%E3%82%B0%E3%83%AB%E3%83%9E%E3%82%B0-300/p/26241",
               prefecture_id: 1,
               popularity: 5,
               camp_memo: "早く欲しい！",
               user_id: 1)
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
