# frozen_string_literal: true

module StubIpstackHelper
  URL_PATH = 'spec/fixtures/geolocations/'

  def geolocation_from_fixture(file)
    fixture = File.read("#{URL_PATH}#{file}")

    JSON.parse(fixture).deep_symbolize_keys
  end

  def error_message_from_fixture(file)
    fixture = File.read("#{URL_PATH}#{file}")
    data = JSON.parse(fixture).deep_symbolize_keys

    data[:error]
  end
end
