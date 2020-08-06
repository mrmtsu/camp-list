class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.text :reference
      t.integer :prefecture_id
      t.date :shooting
      t.integer :popularity
      t.text :camp_memo
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :articles, [:user_id, :created_at]
  end
end
