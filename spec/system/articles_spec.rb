require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:article) { create(:article, :picture, user: user) }
  let!(:comment) { create(:comment, user_id: user.id, article: article) }
  let!(:log) { create(:log, article: article) }

  describe "投稿登録ページ" do
    before do
      login_for_system(user)
      visit new_article_path
    end

    context "ページレイアウト" do
      it "「投稿登録」の文字列が存在すること" do
        expect(page).to have_content '投稿登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('投稿登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '説明'
        expect(page).to have_content '場所'
        expect(page).to have_content '撮影日'
        expect(page).to have_content 'アイテム参照用URL'
        expect(page).to have_content 'おすすめ度 [1~5]'
        expect(page).to have_content 'キャンプメモ'
      end
    end

    context "投稿登録処理" do
      it "有効な情報で投稿登録を行うと投稿登録成功のフラッシュが表示されること" do
        fill_in "タイトル", with: "行ってきた!"
        fill_in "説明", with: "あったら便利グッズ！"
        fill_in "アイテム参照用URL", with: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2"
        select '北海道', from: '場所'
        fill_in "おすすめ度", with: 5
        attach_file "article[picture]", "#{Rails.root}/spec/fixtures/test_article.jpg"
        click_button "登録する"
        expect(page).to have_content "投稿が登録されました！"
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "タイトル", with: "行ってきた!"
        select '北海道', from: '場所'
        click_button "登録する"
        expect(page).to have_link(href: article_path(Article.first))
      end

      it "無効な情報で投稿登録を行うと投稿登録失敗のフラッシュが表示されること" do
        fill_in "タイトル", with: ""
        fill_in "説明", with: "あったら便利グッズ！"
        fill_in "アイテム参照用URL", with: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2"
        select '北海道', from: '場所'
        fill_in "おすすめ度", with: 5
        click_button "登録する"
        expect(page).to have_content "タイトルを入力してください"
      end
    end
  end

  describe "投稿編集ページ" do
    before do
      login_for_system(user)
      visit article_path(article)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('投稿情報の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'タイトル'
        expect(page).to have_content '説明'
        expect(page).to have_content '場所'
        expect(page).to have_content '撮影日'
        expect(page).to have_content 'アイテム参照用URL'
        expect(page).to have_content 'おすすめ度 [1~5]'
        expect(page).to have_content 'キャンプメモ'
      end
    end

    context "投稿の更新処理" do
      it "有効な更新" do
        fill_in "タイトル", with: "編集：行ってきた!"
        fill_in "説明", with: "編集：あったら便利グッズ！"
        select '北海道', from: '場所'
        fill_in "アイテム参照用URL", with: "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2"
        fill_in "おすすめ度", with: 1
        attach_file "article[picture]", "#{Rails.root}/spec/fixtures/test_article2.jpg"
        click_button "更新する"
        expect(page).to have_content "投稿情報が更新されました！"
        expect(article.reload.title).to eq "編集：行ってきた!"
        expect(article.reload.description).to eq "編集：あったら便利グッズ！"
        expect(article.reload.prefecture_id).to eq 1
        expect(article.reload.reference).to eq "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2"
        expect(article.reload.popularity).to eq 1
        expect(article.reload.picture.url).to include "test_article2.jpg"
    end

      it "無効な更新" do
        fill_in "タイトル", with: ""
        click_button "更新する"
        expect(page).to have_content 'タイトルを入力してください'
        expect(article.reload.title).not_to eq ""
      end
    end
  end

  describe "投稿詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit article_path(article)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{article.title}")
      end

      it "投稿情報が表示されること" do
        expect(page).to have_content article.title
        expect(page).to have_content article.description
        expect(page).to have_content article.prefecture_id
        expect(page).to have_content article.shooting
        expect(page).to have_no_content article.reference
        expect(page).to have_no_content article.popularity
        expect(page).to have_link nil, href: article_path(article), class: 'article-picture'
      end
    end

    context "コメントの登録＆削除" do
      it "自分の投稿に対するコメントの登録＆削除が正常に完了すること" do
        login_for_system(user)
        visit article_path(article)
        fill_in "comment_content", with: "Good!"
        click_button "コメント"
        within find("#comment-#{Comment.last.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: 'Good!'
        end
        expect(page).to have_content "コメントを追加しました！"
        click_link "削除", href: comment_path(Comment.last)
        expect(page).not_to have_selector 'span', text: 'Good!'
        expect(page).to have_content "コメントを削除しました"
      end

      it "別ユーザーの投稿のコメントには削除リンクが無いこと" do
        login_for_system(other_user)
        visit article_path(article)
        within find("#comment-#{comment.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: comment.content
          expect(page).not_to have_link '削除', href: article_path(article)
        end
      end
    end

    context "ログ登録＆削除" do
      context "投稿詳細ページから" do
        it "自分の投稿に対するログ登録＆削除が正常に完了すること" do
          login_for_system(user)
          visit article_path(article)
          fill_in "log_content", with: "ログ投稿テスト"
          click_button "ログ追加"
          within find("#log-#{Log.first.id}") do
            expect(page).to have_selector 'span', text: "#{article.logs.count}回目"
            expect(page).to have_selector 'span',
                                          text: %Q(#{Log.last.created_at.strftime("%Y/%m/%d(%a)")})
            expect(page).to have_selector 'span', text: 'ログ投稿テスト'
          end
          expect(page).to have_content "キャンプログを追加しました！"
          click_link "削除", href: log_path(Log.first)
          expect(page).not_to have_selector 'span', text: 'ログ投稿テスト'
          expect(page).to have_content "キャンプログを削除しました"
        end

        it "別ユーザーの投稿ログにはログ登録フォームが無いこと" do
          login_for_system(other_user)
          visit article_path(article)
          expect(page).not_to have_button "作る"
        end
      end
    end
  end

  context "検索機能" do
    context "ログインしている場合" do
      before do
        login_for_system(user)
        visit root_path
      end

      it "ログイン後の各ページに検索窓が表示されていること" do
        expect(page).to have_css 'form#article_search'
        visit users_path
        expect(page).to have_css 'form#article_search'
        visit user_path(user)
        expect(page).to have_css 'form#article_search'
        visit edit_user_path(user)
        expect(page).to have_css 'form#article_search'
        visit following_user_path(user)
        expect(page).to have_css 'form#article_search'
        visit followers_user_path(user)
        expect(page).to have_css 'form#article_search'
        visit articles_path
        expect(page).to have_css 'form#article_search'
        visit article_path(article)
        expect(page).to have_css 'form#article_search'
        visit new_article_path
        expect(page).to have_css 'form#article_search'
        visit edit_article_path(article)
        expect(page).to have_css 'form#article_search'
      end

      it "フィードの中から検索ワードに該当する結果が表示されること" do
        create(:article, title: 'キャンプ飯', user: user)
        create(:article, title: 'キャンプレシピ', user: other_user)
        create(:article, title: '野菜炒め', user: user)
        create(:article, title: '野菜カレー', user: other_user)

        fill_in 'q_title_cont', with: 'キャンプ'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”キャンプ”の検索結果：1件"
        within find('.articles-main') do
          expect(page).to have_css 'li', count: 1
        end
        fill_in 'q_title_cont', with: '野菜'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”野菜”の検索結果：1件"
        within find('.articles-main') do
          expect(page).to have_css 'li', count: 1
        end
      end

      it "検索ワードを入れずに検索ボタンを押した場合、投稿一覧が表示されること" do
        fill_in 'q_title_cont', with: ''
        click_button '検索'
        expect(page).to have_css 'h3', text: "投稿一覧"
        within find('.articles-main') do
          expect(page).to have_css 'li', count: Article.count
        end
      end
    end

    context "ログインしていない場合" do
      it "検索窓が表示されないこと" do
        visit root_path
        expect(page).not_to have_css 'form#article_search'
      end
    end
  end

  describe "投稿一覧ページ" do
    context "CSV出力機能" do
      before do
        login_for_system(user)
      end

      it "トップページからCSV出力が行えること" do
        visit root_path
        click_link 'CSV出力'
        expect(page.response_headers['Content-Disposition']).to \
          include("みんなの投稿一覧_#{Time.current.strftime('%Y%m%d_%H%M')}.csv")
      end

      it "プロフィールページからCSV出力が行えること" do
        visit user_path(user)
        click_link 'CSV出力'
        expect(page.response_headers['Content-Disposition']).to \
          include("みんなの投稿一覧_#{Time.current.strftime('%Y%m%d_%H%M')}.csv")
      end
    end
  end
end
