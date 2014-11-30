class Category < ActiveRecord::Base
  belongs_to :timeline

  validates :title, presence: true
end
