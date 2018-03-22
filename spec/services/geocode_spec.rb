require 'rails_helper'

describe 'Geocode' do
  describe 'lat_long' do
    context 'when address is not found' do
      it 'returns an empty hash' do
        address = 'asdasd'
        stub_request(:get, /maps.googleapis.com/).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => { 'status' => 'ZERO_RESULTS' }.to_json, :headers => {})
        expect(Geocode.new(address).lat_long).to eq({ status: 'success', message: 'no matches found'})
      end
    end

    context 'when address is found' do
      it 'returns a hash with keys latitude and longitude' do
        address = 'checkpoint charlie'
        stub_request(:get, /maps.googleapis.com/).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => { 'status' => 'OK', 'results' => [ { geometry: { location: { lat: 52, lng: 13}}}]}.to_json, :headers => {})
        expect(Geocode.new(address).lat_long).to eq({ latitude: 52, longitude: 13 })
      end
    end
  end  
end