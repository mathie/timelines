class Era < ActiveRecord::Base
  belongs_to :timeline

  validates :title, presence: true
  validates :started_on, presence: true
  validates :ended_on, presence: true
end
