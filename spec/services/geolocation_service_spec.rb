# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeolocationService do
  include StubIpstack
  include StubIpstackHelper

  describe '.create' do
    subject { described_class.create(ip_address, url) }

    let(:success_file) { 'success_response.json' }
    let(:ip_address) { geolocation_from_fixture(success_file)[:ip_address] }
    let(:url) { Faker::Internet.url }
    let(:geolocation_data) do
      data = geolocation_from_fixture(success_file)

      {
        'country_name' => data[:country_name],
        'city' => data[:city],
        'latitude' => data[:latitude],
        'longitude' => data[:longitude]
      }
    end

    before do
      stub_success_response(ip_address)
    end

    context 'when the geolocation is successfully created' do
      it 'fetches geolocation data and creates a geolocation record' do
        expect(Geolocation).to receive(:create!).with(
          hash_including(
            ip_address:,
            url:,
            country: geolocation_data['country_name'],
            city: geolocation_data['city'],
            latitude: geolocation_data['latitude'],
            longitude: geolocation_data['longitude']
          )
        )

        subject
      end
    end

    context 'when the geolocation API returns an error' do
      let(:file) { 'error_invalid_fields_response.json' }
      let(:invalid_ip_address_message) do
        error = error_message_from_fixture(file)
        I18n.t('errors.ipstack_client', code: error[:code].to_i, info: error[:info], ip_address: "#{ip_address}#{url}")
      end

      before do
        stub_error_response(ip_address, file)
      end

      it 'raises a GeolocationError with the error message' do
        expect { subject }.to raise_error(GeolocationError, invalid_ip_address_message)
      end
    end

    context 'when an unexpected error occurs' do
      let(:something_went_wrong_message) { 'Something went wrong' }

      before do
        allow(Geolocation).to receive(:create!).and_raise(StandardError, something_went_wrong_message)
      end

      it 'raises a GeolocationError with the unexpected error message' do
        expect { subject }.to raise_error(GeolocationError, something_went_wrong_message)
      end
    end
  end
end
