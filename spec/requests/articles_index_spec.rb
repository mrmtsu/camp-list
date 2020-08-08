require "rails_helper"

RSpec.describe "投稿一覧ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  context "ログインしているユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get articles_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('articles/index')
    end

    it "CSV出力がエラーなく行えること" do
      login_for_request(user)
      get articles_path(format: :csv)
      expect(response).to have_http_status "200"
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get articles_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
