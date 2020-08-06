class CreateLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :logs do |t|
      t.integer :article_id
      t.text :content

      t.timestamps
    end
    add_index :logs, :article_id
  end
end
