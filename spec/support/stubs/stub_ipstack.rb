# frozen_string_literal: true

require 'webmock/rspec'

module StubIpstack
  BASE_URL = 'http://api.ipstack.com/'
  ACCESS_KEY = ENV['IPSTACK_ACCESS_KEY']
  URL_PATH = 'spec/fixtures/geolocations/'

  def stub_success_response(ip_address)
    url = "#{BASE_URL}#{ip_address}?access_key=#{ACCESS_KEY}"
    response = File.read("#{URL_PATH}success_response.json")
    stub_request(:get, url).and_return(status: 200, body: response)
  end

  def stub_error_response(ip_address, file)
    url = "#{BASE_URL}#{ip_address}?access_key=#{ACCESS_KEY}"
    response = File.read("#{URL_PATH}#{file}")
    stub_request(:get, url).and_return(status: 200, body: response)
  end
end
