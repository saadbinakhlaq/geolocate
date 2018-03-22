# Ruby version 
2.3.2

# Configuration

Add google maps api key to the env
`$ export GOOGLE_MAPS_API_KEY=YOUR_API_KEY`

# Setup

run `bundle install`

# How to run the test suite

`$ rake`

# Usage

start the rails server
`rails s`
go to `/locations` and add address params as

```
 GET /locations/?address=checkpoint charlie
```
