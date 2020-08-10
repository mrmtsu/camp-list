# アプリケーションの概要

キャンプスタイルを記録して共有できる SNS サービス。
https://camp-photo0806.herokuapp.com/

# アプリケーション機能

・投稿機能
・画像リサイズ（CarrierWave を使用）
・キャンプログ登録（キャンプをした度にログを追加し、これまでにいつ作ったか、次回の改善点を記録できる）
・フォロー、フォロワー機能
・お気に入り登録機能
・コメント機能
・通知機能
・検索（Ransack を使用）機能
・CSV 出力機能
・ログイン機能
・ログイン状態の保持機能
・モデルに対するバリデーション
・RSpec で Model, Request, System テスト記述（計 177examples）
・Ajax を用いた非同期処理（フォロー/未フォロー、お気に入り登録/未登録などの切り替え表示）
・Docker を用いた開発
・自動テスト化（CI）
・画像を S ３へアップロード

# 環境

CI / Docker / Ruby / Ruby on Rails / Postgresql / Javascript / S3 / Heroku / GitHub / Travis
