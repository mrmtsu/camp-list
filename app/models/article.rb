class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :popularity,
            :numericality => {
              :only_interger => true,
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 5
            },
            allow_nil: true
  validate  :picture_size

  def feed_comment(article_id)
    Comment.where("article_id = ?", article_id)
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "：5MBより大きい画像はアップロードできません。")
    end
  end
end
