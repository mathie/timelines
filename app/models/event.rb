class Event < ActiveRecord::Base
  belongs_to :category
  belongs_to :timeline

  validates :started_on, presence: true
  validates :title, presence: true

  validate :must_end_after_start

  mount_uploader :image, EventImageUploader

  private

  def must_end_after_start
    if started_on.present? && ended_on.present? && ended_on < started_on
      errors.add(:ended_on, 'must be after started on')
    end
  end
end
