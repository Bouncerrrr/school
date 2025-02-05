FactoryBot.define do
    factory :tutor do
        sequence(:name) { |n| "John#{n}" }
        sequence(:surname) { |n| "Doe#{n}" }
        sequence(:tutor_specialization) { |n| "Math#{n}" }
        hourly_price { rand(10..100) }
    end
  end
  