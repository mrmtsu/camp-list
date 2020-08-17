# CAMP
![ポートフォリオ](https://user-images.githubusercontent.com/60598010/90415214-c11c1180-e0eb-11ea-91e3-c7595aa23e5d.jpg)
 <br>

# アプリケーションの概要

- キャンプスタイルを記録して共有できる SNS サービス。
- https://camp-photo0806.herokuapp.com/

 <br>

## 制作背景
- ❶ キャンプを始めたいけど参考になるものがない。<br>
　（雑誌だと１ヶ月待たないといけない・Webサイトは広告が多く押し付け感が強い）
- ❷ 前回のキャンプで「もっとこうした方がよかった」・「次はあれを持ってこよう」などといったその時々に思いついたことを忘れてしまい次に活かせない。
 <br>
- このような不を改善するために制作しました。
 <br>
- ❶ 他の人がどんなキャンプをしているか写真で共有できる。<br>
　（企業の押し付け感がなく情報の信憑性が上がる）
- ❷ ログ機能をつけることで改善点やよかった点を記録でき見返すことができる。

 <br>

# アプリケーション機能

- 投稿機能
- 画像リサイズ（CarrierWave を使用）
- キャンプログ登録（キャンプをした度にログを追加し、これまでにいつ作ったか、次回の改善点を記録できる）
- フォロー、フォロワー機能
- お気に入り登録機能
- コメント機能
- 通知機能
- 検索（Ransack を使用）機能
- CSV 出力機能
- ログイン機能
- ログイン状態の保持機能
- モデルに対するバリデーション

 <br>
 
- RSpec で Model, Request, System テスト記述（計 177examples）
- Ajax を用いた非同期処理（フォロー/未フォロー、お気に入り登録/未登録などの切り替え表示）
- Docker を用いた開発
- 自動テスト化（CI）
- 自動デプロイ化（CD）
- 画像をS３へアップロード
 <br>

# 環境

- CI/CD / Docker / Ruby / Ruby on Rails / Postgresql / Javascript / S3 / Heroku / GitHub / Travis
 <br>

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|introduction|text||
|sex|string||
|password_digest|string|null: false|
|remember_digest|string||
|admin|boolean||
|boolean|boolean||
### Association
- has_many :articles
- has_many :comments
- has_many :favorite


## articlesテーブル
|Column|Type|Options|
|------|----|-------|
|title|text|null: false|
|description|text|null: false|
|reference|text||
|prefecture_id|integer||
|shooting|date||
|popularity|integer||
|camp_memo|text||
|picture|string||
|user|references|foreign_key: true|
### Association
- belongs_to :user
- has_many :comments

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user|references|foreign_key: true|
|article|references|foreign_key: true|
### Association
- belongs_to :article
- belongs_to :user

## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|article_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :article
- belongs_to :user

## logsテーブル
|Column|Type|Options|
|------|----|-------|
|article_id|integer||
|content|text||
### Association
- belongs_to :article


## notificationsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|article_id|integer||
|variety|integer||
|content|text||
|from_user_id|integer||
### Association
- belongs_to :user
- belongs_to :article

## favoritesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false|
|article|references|null: false|
### Association
- belongs_to :article
- belongs_to :user
