class Lesson < ApplicationRecord
    belongs_to :tutor
  
    validates :lesson_date, presence: true
    validates :tutor_id, presence: true
  end