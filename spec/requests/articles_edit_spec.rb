require "rails_helper"

RSpec.describe "料理編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let(:picture2_path) { File.join(Rails.root, 'spec/fixtures/test_article2.jpg') }
  let(:picture2) { Rack::Test::UploadedFile.new(picture2_path) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_article_path(article)
      login_for_request(user)
      expect(response).to redirect_to edit_article_url(article)
      patch article_path(article), params: { article: { title: "行ってきた！",
                                                        description: "あったら便利グッズ！",
                                                        reference: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2",
                                                        prefecture_id: 1,
                                                        shooting: "",
                                                        popularity: 5,
                                                        camp_memo: "",
                                                        picture: picture2 } }
      redirect_to article
      follow_redirect!
      expect(response).to render_template('articles/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get edit_article_path(article)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      patch article_path(article), params: { article: { title: "行ってきた！",
                                                        description: "あったら便利グッズ！",
                                                        reference: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2",
                                                        prefecture_id: 1,
                                                        shooting: "",
                                                        popularity: 5,
                                                        camp_memo: "" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      login_for_request(other_user)
      get edit_article_path(article)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      patch article_path(article), params: { article: { title: "行ってきた！",
                                                        description: "あったら便利グッズ！",
                                                        reference: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2",
                                                        prefecture_id: 1,
                                                        shooting: "",
                                                        popularity: 5,
                                                        camp_memo: "" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
