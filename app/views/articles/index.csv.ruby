require 'csv'

CSV.generate do |csv|
  csv_column_labels = %w(タイトル 説明 投稿者 アイテム参照用URL\
                         場所 撮影日 おすすめ度 最初に投稿した日時)
  csv << csv_column_labels
  current_user.feed.each do |article|
    csv_column_values = [
      article.title,
      article.description,
      article.user.name,
      article.reference,
      article.prefecture_id,
      article.shooting,
      article.popularity,
      article.created_at.strftime("%Y/%m/%d(%a)")
    ]
    csv << csv_column_values
  end
end
