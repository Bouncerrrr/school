class Lesson < ApplicationRecord
  belongs_to :tutor

  validates :lesson_date, presence: true
  validate :lesson_date_cannot_be_in_the_past

  private

  def lesson_date_cannot_be_in_the_past
    if lesson_date.present? && lesson_date < Date.today
      errors.add(:lesson_date, "Cannot add lessons in the past")
    end
  end
end
