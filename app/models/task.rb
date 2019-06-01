class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :comments
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  validates :user, presence: true
  validates :description, presence: true
  validates :total_hours, numericality: { greater_than: 0 }
  validates :user_id, presence: true
end
