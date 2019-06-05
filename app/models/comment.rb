class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  validates :user_id, presence: true
  validates :description, presence: true
  has_one_attached :file
end
