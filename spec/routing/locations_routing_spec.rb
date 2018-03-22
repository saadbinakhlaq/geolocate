require 'rails_helper'

describe 'routes for locations' do
  it 'routes to locations#show' do
    expect(
      get: '/locations'
    ).to route_to(controller: 'locations', action: 'show', format: :json)
  end
end