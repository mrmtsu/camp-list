require "rails_helper"

RSpec.describe "投稿登録", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  context "ログインしているユーザーの場合" do
    before do
      get new_article_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_article_url
      end
    end

    it "有効な投稿データで登録できること" do
      expect {
        post articles_path, params: { article: { title: "行ってきた！",
                                            description: "あったら便利グッズ！",
                                            reference: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2",
                                            prefecture_id: 1,
                                            shooting: "",
                                            popularity: 5,
                                            camp_memo: "" } }
      }.to change(Article, :count).by(1)
      follow_redirect!
      expect(response).to render_template('articles/show')
    end

    it "無効な投稿データでは登録できないこと" do
      expect {
        post articles_path, params: { article: { title: "",
                                            description: "あったら便利グッズ！",
                                            reference: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2",
                                            prefecture_id: 1,
                                            shooting: "",
                                            popularity: 5,
                                            camp_memo: "" } }
      }.not_to change(Article, :count)
      expect(response).to render_template('articles/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_article_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
