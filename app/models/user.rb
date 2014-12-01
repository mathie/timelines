class User < ActiveRecord::Base
  has_many :authenticators, dependent: :destroy
end
