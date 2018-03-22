require 'httparty'

class Geocode
  API_KEY  = Rails.application.secrets.google_maps_api_key
  BASE_URI = 'https://maps.googleapis.com'
  PATH     = '/maps/api/geocode/json'

  attr_reader :address

  def initialize(address)
    @address = address
  end

  def lat_long
    response = call_api
    message_body = JSON.parse(response.body)

    case
    when response.code == 200 && message_body['status'] == 'ZERO_RESULTS'
      {
        status: I18n.t('success'),
        message: I18n.t('not_found')
      }
    when response.code == 200 && message_body['status'] == 'OK'
      location = message_body['results'].first['geometry']['location']
      {
        latitude:   location['lat'],
        longitude: location['lng']
      }
    when response.code == 200 && message_body['status'] == 'OVER_QUERY_LIMIT'
      {
        status: I18n.t('error'),
        message: I18n.t('query_limit_exceeded')
      }
    end
  end

  private

  def call_api
    HTTParty.get(BASE_URI + PATH, query: { address: address, api_key: API_KEY })
  end
end