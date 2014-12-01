class Era < ActiveRecord::Base
  belongs_to :timeline

  validates :title, presence: true
  validates :started_on, presence: true
  validates :ended_on, presence: true, after: true

  validate :must_end_after_start

  private

  def must_end_after_start
    if started_on.present? && ended_on.present? && ended_on < started_on
      errors.add(:ended_on, 'must be after started on')
    end
  end
end
