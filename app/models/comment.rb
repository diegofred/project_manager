class Comment < ApplicationRecord
  belongs_to :task
  belongs_to :user
  validates :user_id, presence: true

end
