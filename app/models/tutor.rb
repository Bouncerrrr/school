class Tutor < ApplicationRecord

    validates :name, presence: true, length: { maximum: 40 }
    validates :surname, presence: true, length: { maximum: 40 }
    validates :tutor_specialization, presence: true, length: { maximum: 40 }
    validates :hourly_price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 9999 }
    validates :tutor_specialization, uniqueness: { scope: [:name, :surname], message: "already exists for this tutor" }

    has_many :lessons, dependent: :destroy
  
  end