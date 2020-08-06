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
               reference: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2",
               prefecture_id: 1,
               popularity: 5,
               camp_memo: "早く欲しい！",
               user_id: 1)
end
