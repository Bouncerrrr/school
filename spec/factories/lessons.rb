FactoryBot.define do
    factory :lesson do
      association :tutor
      lesson_date { Date.today }
    end
  end
  