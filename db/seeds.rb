# ユーザー
User.create!(
  [
    {
      name:  "山田 良子",
      email: "yamada@example.com",
      password:              "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name:  "鈴木 恵子",
      email: "suzuki@example.com",
      password:              "password",
      password_confirmation: "password",
    },
    {
      name:  "採用 太郎",
      email: "recruit@example.com",
      password:              "password",
      password_confirmation: "password",
    },
  ]
)

# フォロー関係
user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user3.follow(user1)
user3.follow(user2)

# 投稿
description1 = "超簡単！これぞキャンプ飯！"
description2 = "この前買ったテントを初使用！"
description3 = "焚き火はいいなぁ"
camp_memo1 = "次までに作れる料理を増やしておこう。"
camp_memo2 = "次行く時はタープを持って行こう。"
camp_memo3 = "火起こしを買おう。"

Article.create!(
  [
    {
      title: "スープ",
      user_id: 1,
      description: description1,
      reference: "https://ec.snowpeak.co.jp/snowpeak/ja/%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%86%E3%83%B3/c/2020000?q=%3Acreationtime%3Amountaineering%3A2020070&text=",
      prefecture_id: 1,
      popularity: 3,
      camp_memo: camp_memo1,
      picture: open("#{Rails.root}/public/images/article1.jpg"),
    },
    {
      title: "ジオドーム",
      user_id: 2,
      description: description2,
      reference: "https://www.goldwin.co.jp/ap/item/i/m/NV21800",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo2,
      picture: open("#{Rails.root}/public/images/article2.jpg"),
    },
    {
      title: "焚き火",
      user_id: 3,
      description: description3,
      reference: "https://www.uniflame.co.jp/product/683040",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo3,
      picture: open("#{Rails.root}/public/images/article3.jpg"),

    },
    {
      title: "スープ",
      user_id: 3,
      description: description1,
      reference: "https://ec.snowpeak.co.jp/snowpeak/ja/%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%86%E3%83%B3/c/2020000?q=%3Acreationtime%3Amountaineering%3A2020070&text=",
      prefecture_id: 1,
      popularity: 3,
      camp_memo: camp_memo1,
      picture: open("#{Rails.root}/public/images/article4.jpg"),
    },
    {
      title: "ジオドーム",
      user_id: 1,
      description: description2,
      reference: "https://www.goldwin.co.jp/ap/item/i/m/NV21800",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo2,
      picture: open("#{Rails.root}/public/images/article5.jpg"),
    },
    {
      title: "焚き火",
      user_id: 2,
      description: description3,
      reference: "https://www.uniflame.co.jp/product/683040",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo3,
      picture: open("#{Rails.root}/public/images/article6.jpg"),

    },
    {
      title: "スープ",
      user_id: 2,
      description: description1,
      reference: "https://ec.snowpeak.co.jp/snowpeak/ja/%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%86%E3%83%B3/c/2020000?q=%3Acreationtime%3Amountaineering%3A2020070&text=",
      prefecture_id: 1,
      popularity: 3,
      camp_memo: camp_memo1,
      picture: open("#{Rails.root}/public/images/article7.jpg"),
    },
    {
      title: "ジオドーム",
      user_id: 3,
      description: description2,
      reference: "https://www.goldwin.co.jp/ap/item/i/m/NV21800",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo2,
      picture: open("#{Rails.root}/public/images/article8.jpg"),
    },
    {
      title: "焚き火",
      user_id: 1,
      description: description3,
      reference: "https://www.uniflame.co.jp/product/683040",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo3,
      picture: open("#{Rails.root}/public/images/article9.jpg"),

    },
    {
      title: "スープ",
      user_id: 1,
      description: description1,
      reference: "https://ec.snowpeak.co.jp/snowpeak/ja/%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%86%E3%83%B3/c/2020000?q=%3Acreationtime%3Amountaineering%3A2020070&text=",
      prefecture_id: 1,
      popularity: 3,
      camp_memo: camp_memo1,
      picture: open("#{Rails.root}/public/images/article10.jpg"),
    },
    {
      title: "ジオドーム",
      user_id: 3,
      description: description2,
      reference: "https://www.goldwin.co.jp/ap/item/i/m/NV21800",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo2,
      picture: open("#{Rails.root}/public/images/article11.jpg"),
    },
    {
      title: "焚き火",
      user_id: 2,
      description: description3,
      reference: "https://www.uniflame.co.jp/product/683040",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo3,
      picture: open("#{Rails.root}/public/images/article12.jpg"),

    },
    {
      title: "スープ",
      user_id: 3,
      description: description1,
      reference: "https://ec.snowpeak.co.jp/snowpeak/ja/%E3%83%9E%E3%82%A6%E3%83%B3%E3%83%86%E3%83%B3/c/2020000?q=%3Acreationtime%3Amountaineering%3A2020070&text=",
      prefecture_id: 1,
      popularity: 3,
      camp_memo: camp_memo1,
      picture: open("#{Rails.root}/public/images/article13.jpg"),
    },
    {
      title: "ジオドーム",
      user_id: 2,
      description: description2,
      reference: "https://www.goldwin.co.jp/ap/item/i/m/NV21800",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo2,
      picture: open("#{Rails.root}/public/images/article14.jpg"),
    },
    {
      title: "焚き火",
      user_id: 1,
      description: description3,
      reference: "https://www.uniflame.co.jp/product/683040",
      prefecture_id: 1,
      popularity: 4,
      camp_memo: camp_memo3,
      picture: open("#{Rails.root}/public/images/article15.jpg"),

    }
  ]
)

article3 = Article.find(3)
article6 = Article.find(6)
article12 = Article.find(12)
article13 = Article.find(13)
article14 = Article.find(14)
article15 = Article.find(15)

# お気に入り登録
user3.favorite(article13)
user3.favorite(article14)
user1.favorite(article15)
user2.favorite(article12)

# コメント
article15.comments.create(user_id: user1.id, content: "楽しそう！")
article12.comments.create(user_id: user2.id, content: "いいなー！")

# 通知
user3.notifications.create(user_id: user3.id, article_id: article15.id,
                           from_user_id: user1.id, variety: 1)
user3.notifications.create(user_id: user3.id, article_id: article15.id,
                           from_user_id: user1.id, variety: 2, content: "楽しそう！")
user3.notifications.create(user_id: user3.id, article_id: article12.id,
                           from_user_id: user2.id, variety: 1)
user3.notifications.create(user_id: user3.id, article_id: article12.id,
                           from_user_id: user2.id, variety: 2, content: "いいなー！")

# ログ
Article.all.each do |article|
  Log.create!(article_id: article.id,
              content: article.camp_memo)
end
