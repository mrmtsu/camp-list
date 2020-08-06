require 'rails_helper'

RSpec.describe "Articles", type: :system do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

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
        click_button "登録する"
        expect(page).to have_content "投稿が登録されました！"
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
        click_button "更新する"
        expect(page).to have_content "投稿情報が更新されました！"
        expect(article.reload.title).to eq "編集：行ってきた!"
        expect(article.reload.description).to eq "編集：あったら便利グッズ！"
        expect(article.reload.prefecture_id).to eq 1
        expect(article.reload.reference).to eq "https://www.amazon.co.jp/NORTH-FACE-%E3%82%B6%E3%83%BB%E3%83%8E%E3%83%BC%E3%82%B9%E3%83%95%E3%82%A7%E3%82%A4%E3%82%B9-NV21800-%E3%82%B5%E3%83%95%E3%83%A9%E3%83%B3%E3%82%A4%E3%82%A8%E3%83%AD%E3%83%BC/dp/B07916HVGS/ref=sr_1_2?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=north+face+geo&qid=1596689562&sr=8-2"
        expect(article.reload.popularity).to eq 1
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
        expect(page).to have_content article.reference
        expect(page).to have_content article.popularity
      end
    end
  end
end
