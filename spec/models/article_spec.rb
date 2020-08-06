require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:article_yesterday) { create(:article, :yesterday) }
  let!(:article_one_week_ago) { create(:article, :one_week_ago) }
  let!(:article_one_month_ago) { create(:article, :one_month_ago) }
  let!(:article) { create(:article) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(article).to be_valid
    end

    it "タイトルがなければ無効な状態であること" do
      article = build(:article, title: nil)
      article.valid?
      expect(article.errors[:title]).to include("を入力してください")
    end

    it "タイトルが30文字以内であること" do
      article = build(:article, title: "あ" * 31)
      article.valid?
      expect(article.errors[:title]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      article = build(:article, description: "あ" * 141)
      article.valid?
      expect(article.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      article = build(:article, user_id: nil)
      article.valid?
      expect(article.errors[:user_id]).to include("を入力してください")
    end

    it "おすすめ度が1以上でなければ無効な状態であること" do
      article = build(:article, popularity: 0)
      article.valid?
      expect(article.errors[:popularity]).to include("は1以上の値にしてください")
    end

    it "おすすめ度が5以下でなければ無効な状態であること" do
      article = build(:article, popularity: 6)
      article.valid?
      expect(article.errors[:popularity]).to include("は5以下の値にしてください")
    end
  end

  context "並び順" do
    it "最も最近の投稿が最初の投稿になっていること" do
      expect(article).to eq Article.first
    end
  end
end
