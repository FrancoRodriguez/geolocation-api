# frozen_string_literal: true

class GeolocationService
  def self.create(ip_address, url)
    new(ip_address, url).call
  end

  def initialize(ip_address, url)
    @ip_address = ip_address
    @url = url
    @client = IpstackClient.new
  end

  def call
    raise GeolocationError, geolocation_error if data[:error]

    Geolocation.create!(geolocation_params)
  rescue StandardError => e
    raise GeolocationError, e.message
  end

  private

  attr_reader :ip_address, :url, :client

  def data
    @data ||= client.fetch_geolocation(ip_address).deep_symbolize_keys
  end

  def geolocation_error
    error = data[:error]
    I18n.t('errors.ipstack_client', code: error[:code].to_i, info: error[:info], ip_address: "#{ip_address}#{url}")
  end

  def geolocation_params
    {
      ip_address:,
      url:,
      country: data[:country_name],
      city: data[:city],
      latitude: data[:latitude],
      longitude: data[:longitude]
    }
  end
end
