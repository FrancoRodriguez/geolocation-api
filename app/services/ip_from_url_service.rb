# frozen_string_literal: true

class IpFromUrlService
  require 'resolv'

  def self.resolve(url)
    new(url).resolve
  end

  def initialize(url)
    @url = url
  end

  def resolve
    Resolv.getaddresses(url).first
  rescue Resolv::ResolvError
    nil
  end

  private

  attr_reader :url
end
