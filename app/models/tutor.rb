class Tutor < ApplicationRecord
  before_save :capitalize_fields

  validates :name, presence: true, length: { maximum: 40 }
  validates :surname, presence: true, length: { maximum: 40 }
  validates :tutor_specialization, presence: true, length: { maximum: 40 }
  validates :hourly_price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 9999 }
  validates :tutor_specialization, uniqueness: { scope: [:name, :surname], message: "already exists for this tutor" }

  has_many :lessons, dependent: :destroy

  def capitalize_fields
    self.name = name.strip.capitalize if name.present?
    self.surname = surname.strip.capitalize if surname.present?
    self.tutor_specialization = tutor_specialization.strip.capitalize if tutor_specialization.present?
  end
end