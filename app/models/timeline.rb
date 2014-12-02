class Timeline < ActiveRecord::Base
  has_many :categories, dependent: :destroy
  has_many :eras, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true

  mount_uploader :cover_image, CoverImageUploader

  def self.public
    where(public: true)
  end
end
