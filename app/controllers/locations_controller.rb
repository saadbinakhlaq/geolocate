class LocationsController < ApplicationController
  def show
    locations = Geocode.new(addres_param).lat_long
    render json: locations
  rescue ActionController::ParameterMissing
    render json: { message: I18n.t('.address_params_missing'), status: 'error' },
    status: :bad_request
  end

  private

  def addres_param
    params.require(:address)
  end
end
