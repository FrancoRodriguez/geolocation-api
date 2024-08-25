# frozen_string_literal: true

module Api
  module V1
    class GeolocationsController < ApplicationController
      require 'ipaddr'
      before_action :validate_ip_or_url_presence, only: :create

      def index
        geolocations = Geolocation.all
        render json: { geolocations: }, status: :ok
      end

      def create
        return render json: { geolocation: }, status: :ok if geolocation.present?

        geolocation = GeolocationService.create(ip_address, url)

        render json: { geolocation: }, status: :created
      rescue StandardError => e
        render json: { errors: e.message }, status: :unprocessable_entity
      end

      private

      def validate_ip_or_url_presence
        return unless geolocation_params[:ip_or_url].blank?

        render json: { error: I18n.t('errors.geolocations_controller.ip_or_url_blank') },
               status: :unprocessable_entity
      end

      def geolocation
        @geolocation = Geolocation.find_by_ip(ip_address)
      end

      def geolocation_params
        params.require(:geolocation).permit(:ip_or_url)
      end

      def ip_address
        @ip_address ||= valid_ip_address? ? geolocation_params[:ip_or_url] : ip_from_url
      end

      def valid_ip_address?
        !!IPAddr.new(geolocation_params[:ip_or_url])
      rescue StandardError
        false
      end

      def url
        return if valid_ip_address?

        url_without_scheme = geolocation_params[:ip_or_url].sub(%r{\Ahttps?://}, '')
        UrlCleanerService.clean(url_without_scheme)
      end

      def ip_from_url
        IpFromUrlService.resolve(url)
      end
    end
  end
end
