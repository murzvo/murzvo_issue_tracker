# frozen_string_literal: true

FactoryBot.define do
  factory :issue do
    name        { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence(4) }
  end
end
