class Blog::Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  belongs_to :visitor

  default_scope -> { order(created_at: :asc) }

  validates :post_id, presence: true
  validates :content, presence: true, length: {minimum: 1}
end
