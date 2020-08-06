require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }
  let!(:admin_user) { create(:user, :admin) }
  let!(:other_user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:other_article) { create(:article, user: other_user) }

  describe "ユーザー一覧ページ" do
    context "管理者ユーザーの場合" do
      it "ぺージネーション、自分以外のユーザーの削除ボタンが表示されること" do
        create_list(:user, 30)
        login_for_system(admin_user)
        visit users_path
        expect(page).to have_css "div.pagination"
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          expect(page).to have_content "#{u.name} | 削除" unless u == admin_user
        end
      end
    end

    context "管理者ユーザー以外の場合" do
      it "ぺージネーション、自分のアカウントのみ削除ボタンが表示されること" do
        create_list(:user, 30)
        login_for_system(user)
        visit users_path
        expect(page).to have_css "div.pagination"
        User.paginate(page: 1).each do |u|
          expect(page).to have_link u.name, href: user_path(u)
          if u == user
            expect(page).to have_content "#{u.name} | 削除"
          else
            expect(page).not_to have_content "#{u.name} | 削除"
          end
        end
      end
    end
  end

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "ユーザー名", with: "Example User"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "password"
        click_button "登録する"
        expect(page).to have_content "CAMPへようこそ！"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "password"
        fill_in "パスワード(確認)", with: "pass"
        click_button "登録する"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "パスワード(確認)とパスワードの入力が一致しません"
      end
    end
  end

  describe "プロフィール編集ページ" do
    before do
      login_for_system(user)
      visit user_path(user)
      click_link "プロフィール編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール編集')
      end
    end

    it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
      fill_in "ユーザー名", with: "Edit Example User"
      fill_in "メールアドレス", with: "edit-user@example.com"
      fill_in "自己紹介", with: "編集：初めまして"
      fill_in "性別", with: "編集：男性"
      click_button "更新する"
      expect(page).to have_content "プロフィールが更新されました！"
      expect(user.reload.name).to eq "Edit Example User"
      expect(user.reload.email).to eq "edit-user@example.com"
      expect(user.reload.introduction).to eq "編集：初めまして"
      expect(user.reload.sex).to eq "編集：男性"
    end

    it "無効なプロフィール更新をしようとすると、適切なエラーメッセージが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      click_button "更新する"
      expect(page).to have_content 'ユーザー名を入力してください'
      expect(page).to have_content 'メールアドレスを入力してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
      expect(user.reload.email).not_to eq ""
    end
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        create_list(:article, 10, user: user)
        visit user_path(user)
      end

      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール')
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
        expect(page).to have_content user.sex
      end

      it "プロフィール編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
      end

      it "投稿の件数が表示されていることを確認" do
        expect(page).to have_content "投稿 (#{user.articles.count})"
      end

      it "投稿の情報が表示されていることを確認" do
        Article.take(5).each do |article|
          expect(page).to have_link article.title
          expect(page).to have_content article.description
          expect(page).to have_content article.user.name
          expect(page).to have_content article.prefecture_id
          expect(page).to have_content article.popularity
        end
      end

      it "投稿のページネーションが表示されていることを確認" do
        expect(page).to have_css "div.pagination"
      end
    end

    context "お気に入り登録/解除" do
      before do
        login_for_system(user)
      end

      it "投稿のお気に入り登録/解除ができること" do
        expect(user.favorite?(article)).to be_falsey
        user.favorite(article)
        expect(user.favorite?(article)).to be_truthy
        user.unfavorite(article)
        expect(user.favorite?(article)).to be_falsey
      end

      it "お気に入り一覧ページが期待通り表示されること" do
        visit favorites_path
        expect(page).not_to have_css ".favorite-article"
        user.favorite(article)
        user.favorite(other_article)
        visit favorites_path
        expect(page).to have_css ".favorite-article", count: 2
        expect(page).to have_content article.title
        expect(page).to have_content article.description
        expect(page).to have_content "articled by #{user.name}"
        expect(page).to have_link user.name, href: user_path(user)
        expect(page).to have_content other_article.title
        expect(page).to have_content other_article.description
        expect(page).to have_content "articled by #{other_user.name}"
        expect(page).to have_link other_user.name, href: user_path(other_user)
        user.unfavorite(other_article)
        visit favorites_path
        expect(page).to have_css ".favorite-article", count: 1
        expect(page).to have_content article.title
      end
    end

    context "通知生成" do
      before do
        login_for_system(user)
      end

      context "自分以外のユーザーの投稿に対して" do
        before do
          visit article_path(other_article)
        end

        it "お気に入り登録によって通知が作成されること" do
          find('.like').click
          visit article_path(other_article)
          expect(page).to have_css 'li.no_notification'
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたの投稿が#{user.name}さんにお気に入り登録されました。"
          expect(page).to have_content other_article.title
          expect(page).to have_content other_article.description
          expect(page).to have_content other_article.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end

        it "コメントによって通知が作成されること" do
          fill_in "comment_content", with: "コメントしました"
          click_button "コメント"
          expect(page).to have_css 'li.no_notification'
          logout
          login_for_system(other_user)
          expect(page).to have_css 'li.new_notification'
          visit notifications_path
          expect(page).to have_css 'li.no_notification'
          expect(page).to have_content "あなたの投稿に#{user.name}さんがコメントしました。"
          expect(page).to have_content '「コメントしました」'
          expect(page).to have_content other_article.title
          expect(page).to have_content other_article.description
          expect(page).to have_content other_article.created_at.strftime("%Y/%m/%d(%a) %H:%M")
        end
      end

      context "自分の投稿に対して" do
        before do
          visit article_path(article)
        end

        it "お気に入り登録によって通知が作成されないこと" do
          find('.like').click
          visit article_path(article)
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content 'お気に入りに登録されました。'
          expect(page).not_to have_content article.title
          expect(page).not_to have_content article.description
          expect(page).not_to have_content article.created_at
        end

        it "コメントによって通知が作成されないこと" do
          fill_in "comment_content", with: "自分でコメント"
          click_button "コメント"
          expect(page).to have_css 'li.no_notification'
          visit notifications_path
          expect(page).not_to have_content 'コメントしました。'
          expect(page).not_to have_content '自分でコメント'
          expect(page).not_to have_content other_article.title
          expect(page).not_to have_content other_article.description
          expect(page).not_to have_content other_article.created_at
        end
      end
    end
  end
end
