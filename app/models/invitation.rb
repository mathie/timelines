class Invitation < ActiveRecord::Base
  belongs_to :timeline

  validates :email_address, presence: true
end
