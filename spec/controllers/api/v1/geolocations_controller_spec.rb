# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::GeolocationsController, type: :controller do
  include StubIpstack

  let(:valid_ip) { Faker::Internet.ip_v4_address }
  let(:invalid_ip) { '999.999.999.999' }
  let(:valid_url) { Faker::Internet.url }
  let(:cleaned_url) { valid_url.sub(%r{\Ahttps?://}, '') }
  let(:geolocation) { create(:geolocation, ip_address: valid_ip) }
  let(:geolocation_params) { { ip_or_url: valid_ip } }
  let(:valid_api_key) { ENV['API_KEY'] }
  let(:expected_error_message) { I18n.t('errors.geolocations_controller.ip_or_url_blank') }

  before do
    request.headers['API-Key'] = valid_api_key
    stub_success_response(valid_ip)
  end

  describe 'POST #create' do
    context 'when the geolocation does not exist' do
      before do
        allow(IpFromUrlService).to receive(:resolve).with(cleaned_url).and_return(valid_ip)
        post :create, params: { geolocation: { ip_or_url: valid_ip } }, as: :json
      end

      it 'creates a new geolocation and returns it' do
        expect(response).to have_http_status(:created)
        expect(response_json['geolocation']).to include('ip_address' => valid_ip)
      end
    end

    context 'when the geolocation already exists' do
      before do
        create(:geolocation, ip_address: valid_ip)
        post :create, params: { geolocation: { ip_or_url: valid_ip } }, as: :json
      end

      it 'returns the existing geolocation' do
        expect(response).to have_http_status(:ok)
        expect(response_json['geolocation']).to include('ip_address' => valid_ip)
      end
    end

    context 'when ip_or_url is empty' do
      before { post :create, params: { geolocation: { ip_or_url: '' } }, as: :json }

      it 'returns ip or url blank error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json['error']).to eq(expected_error_message)
      end
    end

    context 'when an error occurs during creation' do
      let(:error_message) { 'An error occurred while creating the geolocation' }
      before do
        allow(GeolocationService).to receive(:create).and_raise(StandardError, error_message)
        post :create, params: { geolocation: geolocation_params }, as: :json
      end

      it 'returns an error message' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_json['errors']).to eq(error_message)
      end
    end
  end

  private

  def response_json
    JSON.parse(response.body)
  end
end
