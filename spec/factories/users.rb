# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username              { Faker::Internet.username }
    role                  :regular
    password              'password'
    password_confirmation 'password'

    trait :regular do
      role :regular
    end

    trait :manager do
      role :manager
    end
  end
end
