require 'rails_helper'

RSpec.describe "ログ機能", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:log) { create(:log, article: article) }

  context "ログ登録" do
    context "ログインしている場合" do
      context "投稿を作成したユーザーである場合" do
        before do
          login_for_request(user)
        end

        it "有効なログが登録できること" do
          expect {
            post logs_path, params: { article_id: article.id,
                                      log: { content: "タープもいいかも" } }
          }.to change(article.logs, :count).by(1)
          expect(response).to redirect_to article_path(article)
        end

        it "無効なログが登録できないこと" do
          expect {
            post logs_path, params: { article_id: nil,
                                      log: { content: "タープもいいかも" } }
          }.not_to change(article.logs, :count)
        end
      end

      context "投稿を作成したユーザーでない場合" do
        it "ログ登録できず、トップページへリダイレクトすること" do
          login_for_request(other_user)
          expect {
            post logs_path, params: { article_id: article.id,
                                      log: { content: "タープもいいかも" } }
          }.not_to change(article.logs, :count)
          expect(response).to redirect_to root_path
        end
      end
    end

    context "ログインしていない場合" do
      it "ログ登録できず、ログインページへリダイレクトすること" do
        expect {
          post logs_path, params: { article_id: article.id,
                                    log: { content: "タープもいいかも" } }
        }.not_to change(article.logs, :count)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "ログ削除" do
    context "ログインしている場合" do
      context "ログを作成したユーザーである場合" do
        it "ログ削除ができること" do
          login_for_request(user)
          expect {
            delete log_path(log)
          }.to change(article.logs, :count).by(-1)
        end
      end

      context "ログを作成したユーザーでない場合" do
        it "ログ削除はできず、投稿詳細ページへリダイレクトすること" do
          login_for_request(other_user)
          expect {
            delete log_path(log)
          }.not_to change(article.logs, :count)
          expect(response).to redirect_to article_path(article)
        end
      end
    end

    context "ログインしていない場合" do
      it "ログ削除はできず、ログインページへリダイレクトすること" do
        expect {
          delete log_path(log)
        }.not_to change(article.logs, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end
