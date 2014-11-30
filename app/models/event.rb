class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :timeline

  validates :started_on, presence: true
  validates :title, presence: true
end
