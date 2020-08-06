class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :article_id, presence: true
end
