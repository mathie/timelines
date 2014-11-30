class Timeline < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  has_many :eras, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
end
