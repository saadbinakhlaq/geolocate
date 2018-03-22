class LocationsController < ApplicationController
  def show
    locations = Geocode.new(addres_param).lat_long
    render json: locations
  rescue ActionController::ParameterMissing
    render json: { message: 'address params missing', status: 'error' },
    status: :bad_request
  end

  private

  def addres_param
    params.require(:address)
  end
end
