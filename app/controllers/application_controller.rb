# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    api_key = request.headers['API-Key']
    render json: { error: 'Unauthorized' }, status: :unauthorized unless api_key == ENV['API_KEY']
  end
end
