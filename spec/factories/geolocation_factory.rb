# frozen_string_literal: true

FactoryBot.define do
  factory :geolocation do
    ip_address { Faker::Internet.ip_v4_address }
    url { Faker::Internet.url }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    city { Faker::Address.city }
    country { Faker::Address.country }
  end
end
