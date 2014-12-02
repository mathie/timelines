class User < ActiveRecord::Base
  has_many :authenticators, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :timelines, through: :collaborations
end
