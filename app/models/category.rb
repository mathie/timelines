class Category < ActiveRecord::Base
  belongs_to :timeline
  has_many :events, dependent: :destroy

  validates :title, presence: true
end
