class Article < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

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
end
