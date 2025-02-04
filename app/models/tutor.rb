class Tutor < ApplicationRecord
  before_save :capitalize_fields

  has_many :lessons, dependent: :destroy

  validates :name, presence: { message: "Name cannot be empty." }, 
                   length: { maximum: 40, message: "Name cannot be longer than 40 characters." }

  validates :surname, presence: { message: "Surname cannot be empty." }, 
                      length: { maximum: 40, message: "Surname cannot be longer than 40 characters." }

  validates :tutor_specialization, presence: { message: "Specialization cannot be empty." }, 
                                   length: { maximum: 40, message: "Specialization cannot be longer than 40 characters." },
                                   uniqueness: { scope: [:name, :surname], message: "has already been assigned to this tutor. Please choose a different specialization." }

  validates :hourly_price, presence: { message: "Hourly price is required." }, 
                           numericality: { 
                             only_integer: true, message: "Hourly price must be a whole number.", 
                             greater_than: 0, message: "Hourly price must be greater than 0.", 
                             less_than_or_equal_to: 9999, message: "Hourly price cannot exceed 9999."
                           }

  private

  def capitalize_fields
    self.name = name.strip.titleize if name.present?
    self.surname = surname.strip.titleize if surname.present?
    self.tutor_specialization = tutor_specialization.strip.titleize if tutor_specialization.present?
  end
end
