class Log < ApplicationRecord
  belongs_to :article
  default_scope -> { order(created_at: :desc) }
  validates :article_id, presence: true
end
