# frozen_string_literal: true

require 'httparty'

class IpstackClient
  BASE_URL = 'http://api.ipstack.com/'
  ACCESS_KEY = ENV['IPSTACK_ACCESS_KEY']

  def fetch_geolocation(ip_or_url)
    response = HTTParty.get("#{BASE_URL}#{ip_or_url}?access_key=#{ACCESS_KEY}")
    JSON.parse(response.body)
  end
end
