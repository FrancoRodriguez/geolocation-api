# frozen_string_literal: true

module GeolocationRepository
  extend ActiveSupport::Concern

  included do
    def self.find_by_ip(ip_address)
      return if ip_address.blank?

      find_by(ip_address:)
    end
  end
end
