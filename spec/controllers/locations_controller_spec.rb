require 'rails_helper'

describe LocationsController, type: :controller do
  describe 'GET #show' do
    context 'when address query params is not given' do
      it 'responds with bad request' do
        get :show
        expect(response.status).to eq(400)
        expect(JSON.parse(response.body)).to eq({ 
          'message' => I18n.t('address_params_missing'),
          'status' => "error"
        })
      end
    end

    context 'when address is not found' do
      it '200 OK responds with json of with empty json string' do
        stub_request(:get, /maps.googleapis.com/).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => { 'status' => 'ZERO_RESULTS' }.to_json, :headers => {})

        get :show, params: { address: 'csadaasdasdsadasds' }
        expect(JSON.parse(response.body)).to eq({
          'status' => I18n.t('success'),
          'message' => I18n.t('not_found')
        })
      end
    end

    context 'when address is found' do
      it '200 OK responds with json of latitude and longitude' do
        stub_request(:get, /maps.googleapis.com/).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => { 'status' => 'OK', 'results' => [ { geometry: { location: { lat: 52, lng: 13}}}]}.to_json, :headers => {})
        get :show, params: { address: 'checkpoint charlie' }
        expect(JSON.parse(response.body)).to eq({
          'latitude'  => 52,
          'longitude' => 13
        })
      end
    end
  end 
end
