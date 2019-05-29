class Project < ApplicationRecord
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  validates :user_id, presence: true

  belongs_to :user
end
