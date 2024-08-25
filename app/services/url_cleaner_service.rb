# frozen_string_literal: true

class UrlCleanerService
  def self.clean(url)
    new(url).clean
  end

  def initialize(url)
    @url = url
  end

  def clean
    path = url.include?('/') ? url.split('/').first : url
    path = path.gsub(/[?&]\z/, '')
    path.gsub(/(?:\?|&).*$/, '')
  end

  private

  attr_reader :url
end
