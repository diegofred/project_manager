class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_many :comments

  # validate
  validates :name, presence: true, length: { minimum: 5 }
  validates :description, presence: true
  validates :user, presence: true
  validates :total_hours, numericality: { greater_than: 0 }

  validates :user_id, presence: true

  before_create :set_inicial_status

  enum status: %i[to_do done]

  def set_inicial_status
    self.status = Task.statuses[:to_do]
  end

  # def get_status
  #   Task.statuses.key(status_id)
  # end

  def as_json(options = {})
    if options.key?(:only) || options.key?(:methods) || options.key?(:include) || options.key?(:except)
      h = super(options = {})
    else
      h = super(except: %i[updated_at status_id],
                include: { comments: { except: %i[updated_at] } })
    end
  end
end
