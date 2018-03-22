When("I perform get request to the locations endpoint with address query params") do
  stub_request(:get, /maps.googleapis.com/).
          with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => { 'status' => 'OK', 'results' => [ { geometry: { location: { lat: 52, lng: 13}}}]}.to_json, :headers => {})
  get '/locations?address=checkpoint+charlie'
end

Then("I should see a valid response") do
  last_response.status.should == 200
end

Then("The JSON response should be valid") do
  last_response.body.should == { latitude: 52, longitude: 13 }.to_json
end