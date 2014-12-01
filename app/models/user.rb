class User < ActiveRecord::Base
  has_many :authenticators, dependent: :destroy
  has_many :timelines, dependent: :destroy
end
