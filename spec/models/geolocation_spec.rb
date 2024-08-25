# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Geolocation, type: :model do
  let(:valid_ip) { Faker::Internet.ip_v4_address }
  let(:invalid_ip) { '999.999.999.999' }

  it 'is valid with a unique, present ip_address' do
    geolocation = Geolocation.new(ip_address: valid_ip)
    expect(geolocation).to be_valid
  end

  it 'is invalid without an ip_address' do
    geolocation = Geolocation.new(ip_address: nil)
    expect(geolocation).not_to be_valid
    expect(geolocation.errors[:ip_address]).to include("can't be blank")
  end

  it 'is invalid with a duplicate ip_address' do
    create(:geolocation, ip_address: valid_ip)
    geolocation = Geolocation.new(ip_address: valid_ip)
    expect(geolocation).not_to be_valid
    expect(geolocation.errors[:ip_address]).to include('has already been taken')
  end
end
