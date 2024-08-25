# frozen_string_literal: true

class Geolocation < ApplicationRecord
  include GeolocationRepository

  validates :ip_address, presence: true, uniqueness: true
end
